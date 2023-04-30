-- Spring
-- littensy
-- September 11, 2020

--[[

    Using: spr (https://devforum.roblox.com/t/spring-driven-motion-spr/714728)
    Author: Fractality
    License: MIT (Copyright (c) 2020 Parker Stebbins. All rights reserved.)

    spring = Spring.new(initialValue, dampingRatio, frequency [, callback])

    spring.Position
    spring.Velocity
    spring.Target
    spring.Damping
    spring.Frequency
    spring.IsPlaying
    spring.Drift

    spring:Start()
    spring:Stop()
    spring:Step([deltaTime])
    spring:SetTarget(target)
    spring:Translate(translation)
    spring:Shove(velocity)

--]]



local Spring = {}
Spring.__index = Spring

local SLEEP_OFFSET_SQ_LIMIT = (1/3840)^2 -- square of the offset sleep limit
local SLEEP_VELOCITY_SQ_LIMIT = 1e-2^2 -- square of the velocity sleep limit
local EPS = 1e-5 -- epsilon for stability checks around pathological frequency/damping values

local pi = math.pi
local min = math.min
local exp = math.exp
local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt

local function magnitudeSq(vec)
	local out = 0
	for _, v in ipairs(vec) do
		out += v^2
	end
	return out
end

local function distanceSq(vec0, vec1)
	local out = 0
	for i0, v0 in ipairs(vec0) do
		out += (vec1[i0] - v0)^2
	end
	return out
end

local metadata = {
    number = {
        toIntermediate = function(value)
            return {value}
        end;
        
        fromIntermediate = function(value)
            return value[1]
        end;
    };

    table = {
        toIntermediate = function(value)
            return {_table = value, table.unpack(value, 1, value.n)}
        end;
        
        fromIntermediate = function(value)
            for idx = 1, #value do
                value._table[idx] = value[idx]
            end
            return value._table
        end;
    };

    NumberRange = {
        toIntermediate = function(value)
            return {value.Min, value.Max}
        end;

        fromIntermediate = function(value)
            return NumberRange.new(value[1], value[2])
        end;
    };

    UDim = {
        toIntermediate = function(value)
            return {value.Scale, value.Offset}
        end;

        fromIntermediate = function(value)
            return UDim.new(value[1], value[2])
        end;
    };

    UDim2 = {
        toIntermediate = function(value)
            local x = value.X
            local y = value.Y
            return {x.Scale, x.Offset, y.Scale, y.Offset}
        end;

        fromIntermediate = function(value)
            return UDim2.new(value[1], value[2], value[3], value[4])
        end;
    };

    Vector2 = {
        toIntermediate = function(value)
            return {value.X, value.Y}
        end;

        fromIntermediate = function(value)
            return Vector2.new(value[1], value[2])
        end;
    };

    Vector3 = {
        toIntermediate = function(value)
            return {value.X, value.Y, value.Z}
        end;

        fromIntermediate = function(value)
            return Vector3.new(value[1], value[2], value[3])
        end;
    };

    CFrame = {
        toIntermediate = function(value)
            -- Get CFrame position
            local x, y, z = value.X, value.Y, value.Z

            -- Convert radians from orientation to sin/cos pairs
            local vX, vY, vZ = value.XVector, value.YVector, value.ZVector

            return {x, y, z, vX.X, vX.Y, vX.Z, vY.X, vY.Y, vY.Z, vZ.X, vZ.Y, vZ.Z}
        end;

        fromIntermediate = function(value)
            -- Get CFrame position
            local pos = Vector3.new(unpack(value, 1, 3))

            -- Convert sin/cos pairs to radians
            local vX, vY, vZ =
                Vector3.new(unpack(value, 4, 6)),
                Vector3.new(unpack(value, 7, 9)),
                Vector3.new(unpack(value, 10))

            return CFrame.fromMatrix(pos, vX.Unit, vY.Unit, vZ.Unit)
        end;
    };

    Color3 = {
        toIntermediate = function(value)
            -- convert RGB to a variant of cieluv space
            local r, g, b = value.R, value.G, value.B

            -- D65 sRGB inverse gamma correction
            r = r < 0.0404482362771076 and r/12.92 or 0.87941546140213*(r + 0.055)^2.4
            g = g < 0.0404482362771076 and g/12.92 or 0.87941546140213*(g + 0.055)^2.4
            b = b < 0.0404482362771076 and b/12.92 or 0.87941546140213*(b + 0.055)^2.4

            -- sRGB -> xyz
            local x = 0.9257063972951867*r - 0.8333736323779866*g - 0.09209820666085898*b
            local y = 0.2125862307855956*r + 0.71517030370341085*g + 0.0722004986433362*b
            local z = 3.6590806972265883*r + 11.4426895800574232*g + 4.1149915024264843*b

            -- xyz -> modified cieluv
            local l = y > 0.008856451679035631 and 116*y^(1/3) - 16 or 903.296296296296*y

            local u, v
            if z > 1e-14 then
                u = l*x/z
                v = l*(9*y/z - 0.46832)
            else
                u = -0.19783*l
                v = -0.46832*l
            end

            return {l, u, v}
        end;

        fromIntermediate = function(value)
            -- convert back from modified cieluv to rgb space

            local l = value[1]
            if l < 0.0197955 then
                return Color3.new(0, 0, 0)
            end
            local u = value[2]/l + 0.19783
            local v = value[3]/l + 0.46832

            -- cieluv -> xyz
            local y = (l + 16)/116
            y = y > 0.206896551724137931 and y*y*y or 0.12841854934601665*y - 0.01771290335807126
            local x = y*u/v
            local z = y*((3 - 0.75*u)/v - 5)

            -- xyz -> D65 sRGB
            local r =  7.2914074*x - 1.5372080*y - 0.4986286*z
            local g = -2.1800940*x + 1.8757561*y + 0.0415175*z
            local b =  0.1253477*x - 0.2040211*y + 1.0569959*z

            -- clamp minimum sRGB component
            if r < 0 and r < g and r < b then
                r, g, b = 0, g - r, b - r
            elseif g < 0 and g < b then
                r, g, b = r - g, 0, b - g
            elseif b < 0 then
                r, g, b = r - b, g - b, 0
            end

            -- gamma correction from D65
            -- clamp to avoid undesirable overflow wrapping behavior on certain properties (e.g. BasePart.Color)
            return Color3.new(
                min(r < 3.1306684425e-3 and 12.92*r or 1.055*r^(1/2.4) - 0.055, 1),
                min(g < 3.1306684425e-3 and 12.92*g or 1.055*g^(1/2.4) - 0.055, 1),
                min(b < 3.1306684425e-3 and 12.92*b or 1.055*b^(1/2.4) - 0.055, 1)
            )
        end;
    };
}

local springs = {}


function Spring.new(initialValue, dampingRatio, frequency, callback)
    
    assert(metadata[typeof(initialValue)], "Invalid type for initial value (" .. typeof(initialValue) .. ")")
    assert(type(dampingRatio) == "number", "Argument #2 'dampingRatio' must be a number")
    assert(type(frequency) == "number", "Argument #3 'frequency' must be a number")
    
    local md = metadata[typeof(initialValue)]
    local position = md.toIntermediate(initialValue)
    local target = md.toIntermediate(initialValue)

	local self = setmetatable({

        Callback = callback;
        Type = typeof(initialValue);

        _damping = tonumber(dampingRatio) or 1;
        _frequency = tonumber(frequency) or 4;
        _position = position;
        _velocity = table.create(#position, 0);
        _speed = 1;
        _target = target;
        _metadata = md;
        _lastUpdate = os.clock();
        _isPlaying = false;
        _drift = false;

	}, Spring)

	return self

end


function Spring:CanSleep()
    if (magnitudeSq(self._velocity) > SLEEP_VELOCITY_SQ_LIMIT) then
        return false
    end
    if (distanceSq(self._position, self._target) > SLEEP_OFFSET_SQ_LIMIT) then
        return false
    end
    return true
end


function Spring:Step(dt)
    -- if (not self:CanSleep()) then
    --     self:_update(dt)
    -- else
    --     self.Value = self.Target
    -- end

    -- if (self.Callback) then
    --     self.Callback(self.Position, dt)
    -- end
  
    if not self:CanSleep() then
        self:_update(dt)
        self.Callback(self.Position, dt)
    elseif self.Value ~= self.Target then
        self.Value = self.Target
        self.Callback(self.Position, dt)
    end
end


function Spring:_update(dt)
	--[[
		This method was originally written by Fractality and is slightly
		modified for this module. The original source can be found in
		the link below, as well as the license:
            https://github.com/Fraktality/spr/blob/master/spr.lua
            https://github.com/Fraktality/spr/blob/master/LICENSE
	--]]
    dt = dt or (os.clock() - self._lastUpdate)
    dt *= self._speed

    local d = self._damping
    local f = self._frequency*2*pi
    local p = self._position
    local v = self._velocity
    local g = self._target

    if (self._drift) then
        g = p
    end

    if (d == 1) then -- critically damped
        local q = exp(-f*dt)
        local w = dt*q

        local c0 = q + w*f
        local c2 = q - w*f
        local c3 = w*f*f

        for idx = 1, #p do
            local o = p[idx] - g[idx]
            p[idx] = o*c0 + v[idx]*w + g[idx]
            v[idx] = v[idx]*c2 - o*c3
        end

    elseif (d < 1) then -- underdamped
        local q = exp(-d*f*dt)
        local c = sqrt(1 - d*d)

        local i = cos(dt*f*c)
        local j = sin(dt*f*c)

        local z
        if c > EPS then
            z = j/c
        else
            local a = dt*f
            z = a + ((a*a)*(c*c)*(c*c)/20 - c*c)*(a*a*a)/6
        end

        local y
        if f*c > EPS then
            y = j/(f*c)
        else
            local b = f*c
            y = dt + ((dt*dt)*(b*b)*(b*b)/20 - b*b)*(dt*dt*dt)/6
        end

        for idx = 1, #p do
            local o = p[idx] - g[idx]
            p[idx] = (o*(i + z*d) + v[idx]*y)*q + g[idx]
            v[idx] = (v[idx]*(i - z*d) - o*(z*f))*q
        end

    else -- overdamped
        local c = sqrt(d*d - 1)

        local r1 = -f*(d - c)
        local r2 = -f*(d + c)

        local ec1 = exp(r1*dt)
        local ec2 = exp(r2*dt)

        for idx = 1, #p do
            local o = p[idx] - g[idx]
            local co2 = (v[idx] - o*r1)/(2*f*c)
            local co1 = ec1*(o - co2)

            p[idx] = co1 + co2*ec2 + g[idx]
            v[idx] = co1*r1 + co2*ec2*r2
        end
    end

    self._lastUpdate = os.clock()

    return self.Position
end


function Spring:SetTarget(value)
    self._target = self._metadata.toIntermediate(value)
    return self.Position
end


function Spring:Shove(impulse)
    impulse = self._metadata.toIntermediate(impulse)
    local velocity = self._velocity
    for i, v in ipairs(impulse) do
        velocity[i] += v
    end
end


function Spring:Translate(translation)
    translation = self._metadata.toIntermediate(translation)
    local position = self._position
    for i, v in ipairs(translation) do
        position[i] += v
    end
end


function Spring:Start()
    if (not self._isPlaying) then
        springs[self] = true
        self._isPlaying = true

        self.Callback(self.Position)
    end
end


function Spring:Stop()
    if (self._isPlaying) then
        springs[self] = nil
        self._isPlaying = false
    end
end


function Spring:__index(key)
    if (Spring[key]) then
        return Spring[key]
    elseif (key == "Position" or key == "Value" or key == "p") then
        return self._metadata.fromIntermediate(self._position)
    elseif (key == "Velocity" or key == "v") then
        return self._metadata.fromIntermediate(self._velocity)
    elseif (key == "Target" or key == "t") then
        return self._metadata.fromIntermediate(self._target)
    elseif (key == "Damping" or key == "d") then
        return self._damping
    elseif (key == "Frequency" or key == "f") then
        return self._frequency
    elseif (key == "Speed") then
        return self._speed
    elseif (key == "Drift") then
        return self._drift
    elseif (key == "Callback") then
        return rawget(self, "Callback")
    elseif (key == "IsPlaying") then
        return self._isPlaying
    else
        error(tostring(key) .. " is not a valid member of Spring")
    end
end


function Spring:__newindex(key, value)
    if (key == "Position" or key == "Value" or key == "p") then
        self._position = self._metadata.toIntermediate(value)
    elseif (key == "Velocity" or key == "v") then
        self._velocity = self._metadata.toIntermediate(value)
    elseif (key == "Target" or key == "t") then
        self._target = self._metadata.toIntermediate(value)
    elseif (key == "Damping" or key == "d") then
        self._damping = tonumber(value) or 1
    elseif (key == "Frequency" or key == "f") then
        self._frequency = tonumber(value) or 4
    elseif (key == "Speed") then
        self._speed = tonumber(value) or 1
    elseif (key == "Drift") then
        self._drift = assert(type(value) == "boolean", "Spring.Drift must be a boolean")
    elseif (key == "Callback") then
        rawset(self, "Callback", type(value) == "function" and value or nil)
    elseif (key == "IsPlaying") then
        error("Cannot set 'IsPlaying' readonly property for Spring")
    else
        error(tostring(key) .. " is not a valid member of Spring")
    end
end


function Spring:__eq(value)
    if (type(value) == "table" and value.Position) then
        return (value.Position == self.Position)
    elseif (typeof(value) == self.Type) then
        return (value == self.Position)
    else
        return rawequal(self, value)
    end
end


game:GetService("RunService").Heartbeat:Connect(function(dt)
    for spring in pairs(springs) do
        spring:Step(dt)
    end
end)


Spring.Impulse = Spring.Shove
Spring.Destroy = Spring.Stop

return Spring