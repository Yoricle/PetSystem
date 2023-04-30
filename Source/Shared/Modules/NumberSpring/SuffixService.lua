-- Suffix Service
-- AmazingRock3r
-- September 14, 2021

local SuffixService = {}

local NumberFormat = {
	{10^174, "Ame"};
	{10^171, "Eg"};
	{10^168, "Th"};
	{10^165, "On"};
	{10^162, "Te"};
	{10^159, "Ri"};
	{10^156, "Vo"};
	{10^153, "Fa"};
	{10^150, "Nd"};
	{10^147, "KeA"};
	{10^144, "Li"};
	{10^141, "Ea"};
	{10^138, "Av"};
	{10^135, "Le"};
	{10^132, "Ol"};
	{10^129, "Co"};
	{10^126, "Ur"};
	{10^123, "If"};
	{10^120, "Os"};
	{10^117, "Di"};
	{10^114, "Stu"};
	{10^111, "Ng"};
	{10^108, "Zi"};
	{10^105, "Ama"};
	{10^102, "In"};
	{10^99, "Jo"};
	{10^96, "y"};
	{10^93, "Gp"};
	{10^90, "G"};
	{10^87, "g"};
	{10^84, "I"};
	{10^81, "i"};
	{10^78, "H"};
	{10^75, "h"};
	{10^72, "Ø"};
	{10^69, "ø"};
	{10^66, "c"};
	{10^63, "v"};
	{10^60, "N"};
	{10^57, "O"};
	{10^54, "St"};
	{10^51, "Sd"};
	{10^48, "Qd"};
	{10^45, "Qt"};
	{10^42, "T"};
	{10^39, "D"};
	{10^36, "U"};
	{10^33, "d"};
	{10^30, "n"};
	{10^27, "o"};
	{10^24, "S"};
	{10^21, "s"};
	{10^18, "Q"},
	{10^15, "q"},
	{10^12, "t"},
	{10^9, "B"},
	{10^6, "M"},
	{10^3, "k"},
}

function SuffixService:FormatNumber(number)
	for Index = 1, #NumberFormat do
		if number >= NumberFormat[Index][1] then
			local s = string.format("%.2f", number / NumberFormat[Index][1])
			if s:sub(s:len() - 2) == ".00" then
				s = s:sub(1, s:len() - 3)
			end
			return s..NumberFormat[Index][2]
		end
	end

	return tostring(math.floor(number))
end;

return SuffixService