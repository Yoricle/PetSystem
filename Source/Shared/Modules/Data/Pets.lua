local ReplicatedStorage = game:GetService("ReplicatedStorage")

local spreadsheetData =
	[[Supersport_8	VR46	Supersport	8	10	3850	Vanquisher		0.654	20	98	250.7	179.85	2.037	1.133	2.82	100000	1	0.6572387344	1	0.875	
	Supersport_7	GrazieVale	Supersport	7	46	46000	Grazie		0.636	20	92	243.8	174.9	2.058	1.122	2.88	100000	0.955165692	0.6356663471	0.9913043478	0.8125	
	Supersport_6	YZR_M1-2	Supersport	6	5	3295	Hammer		0.618	20	86	236.9	169.95	2.079	1.111	2.94	100000	0.910331384	0.6140939597	0.9826086957	0.75	
	_	YZR_M1-2			0	0			0	0	0	0	0	0	0	0	0	-0.6289798571	-0.1265580058	1.408695652	-0.1458333333	
	Supersport_5	2018HondaVR46Moto2-2	Supersport	5	2	3000	Rapid		0.6	20	80	230	165	2.1	1.1	3	100000	0.865497076	0.5925215724	0.9739130435	0.6875	
	_	2018HondaVR46Moto2-2			0	0			0	0	0	0	0	0	0	0	0	-0.6289798571	-0.1265580058	1.408695652	-0.1458333333	
	Supersport_4	Moto3	Supersport	4	30	30000	Swift		0.582	20	74	223.1	160.05	2.121	1.089	3.06	100000	0.820662768	0.570949185	0.9652173913	0.625	
	Classic_3	Laverda	Classic	3	15	3500	Gladiator		0.141	20	25.5	150.4	112.8	4.08	1.274	6.24	20000	0.3482781027	0.04242569511	0.5043478261	0.1197916667	
	Classic_4	Norton_Fairing	Classic	4	20	5000	Signature		0.1455	20	27.75	155.2	116.4	4.04	1.287	6.12	20000	0.3794671865	0.04781879195	0.5217391304	0.1432291667	
	Street_4	Harley_D_Sportster	Street	4	13	3500	Stallion		0.485	20	46.25	184.3	126.1	2.222	0.99	4.08	50000	0.5685510071	0.4546979866	0.8173913043	0.3359375	Chopper
	Street_3	Norton_1961	Street	3	10	3000	Contender		0.47	20	42.5	178.6	122.2	2.244	0.98	4.16	50000	0.5315139701	0.4367209971	0.8057971014	0.296875	
	Street_8	Ducati_Monster	Street	8	150	50000	Centaur		0.545	20	61.25	207.1	141.7	2.134	1.03	3.76	50000	0.7166991553	0.5266059444	0.8637681159	0.4921875	
	Street_5	Guzzi_V8_2	Street	5	25	5000	Mamba		0.5	20	50	190	130	2.2	1	4	50000	0.6055880442	0.472674976	0.8289855072	0.375	
	Chopper_2	Harley_D_Sportster_Easy	Chopper	2	0	5000	Fighter		0.1092	10	15.5	163.8	109.2	6.18	1.261	9.54	100000	0.4353476283	0.004314477469	0.02608695652	0.015625	
	Chopper_4	Harley_Davidson_FatBoy	Chopper	4	0	5000	Brawler		0.1164	10	18.5	174.6	116.4	6.06	1.287	9.18	100000	0.5055230669	0.01294343241	0.07826086957	0.046875	
	Chopper_3	Harley_Fat_Boy_Military	Chopper	3	0	5000	Patriot		0.1128	10	17	169.2	112.8	6.12	1.274	9.36	100000	0.4704353476	0.008628954938	0.05217391304	0.03125	
	Chopper_1	Sportster Rat Bike	Chopper	1	0	2500	Anarchy		0.1056	10	14	158.4	105.6	6.24	1.248	9.72	100000	0.400259909	0	0	0	
	Off-Road_2	Husqvarna_FE350	Off-Road	2	6	1500	Throttler		0.91	30	38.75	122.85	81.9	1.545	1.067	3.18	1000	0.169265757	0.9640460211	0.947826087	0.2578125	
	Off-Road_3	Yamaha_wr450_2013	Off-Road	3	16	3500	Shifter		0.94	30	42.5	126.9	84.6	1.53	1.078	3.12	1000	0.1955815465	1	0.9565217391	0.296875	
	Street_2	Ducati_Scrambler	Street	2	0	2500	Challenger		0.455	20	38.75	172.9	118.3	2.266	0.97	4.24	50000	0.4944769331	0.4187440077	0.7942028986	0.2578125	
	Street_6	Harley_D_Sportster_Dirt	Street	6	50	10000	Rogue		0.515	20	53.75	195.7	133.9	2.178	1.01	3.92	50000	0.6426250812	0.4906519655	0.8405797101	0.4140625	Chopper
	Scooters_4	Lambretta_Mod-2	Scooters	4	20	0	Breeze		0.582	30	46.25	116.4	106.7	2.121	0.99	5.1	15000	0.1273554256	0.570949185	0.6695652174	0.3359375	
	Scooters_5	Lambretta_Mod	Scooters	5	25	0	Mod		0.6	30	50	120	110	2.1	1	5	15000	0.1507472385	0.5925215724	0.684057971	0.375	
	Scooters_1	Honda PA50 (Hobbit)	Scooters	1	3	0	Al Fresco		0.528	30	35	105.6	96.8	2.184	0.96	5.4	15000	0.057179987	0.506232023	0.6260869565	0.21875	
	Scooters_2	Honda_PA50_Mod	Scooters	2	9	0	Shopper		0.546	30	38.75	109.2	100.1	2.163	0.97	5.3	15000	0.08057179987	0.5278044104	0.6405797101	0.2578125	
	Scooters_3	Lambretta	Scooters	3	14	0	River		0.564	30	42.5	112.8	103.4	2.142	0.98	5.2	15000	0.1039636127	0.5493767977	0.6550724638	0.296875	
	Chopper_5	Fat_Boy_Police	Chopper	5	0	9110	Patroller		0.12	10	20	180	120	6	1.3	9	100000	0.5406107862	0.01725790988	0.1043478261	0.0625	
	Adventure_3	GoldWing-2	Adventure	3	23	5000	Silvertail		0.376	50	59.5	188	131.6	2.244	0.98	4.16	50000	0.5925925926	0.3240651965	0.8057971014	0.4739583333	1800cc
	Adventure_2	GoldWing	Adventure	2	18	4000	Orienter		0.364	50	54.25	182	127.4	2.266	0.97	4.24	50000	0.5536062378	0.309683605	0.7942028986	0.4192708333	1800cc
	Adventure_1	Kawasaki_KLR650_Tengai	Adventure	1	7	3000	Discovery		0.352	50	49	176	123.2	2.288	0.96	4.32	50000	0.514619883	0.2953020134	0.7826086957	0.3645833333	
	Special_1	Box	Special	1	0	1250	Compact		0.616	20	56	96.8	96.8	2.184	0.96	5.4	100000	0	0.6116970278	0.6260869565	0.4375	Electric
	Classic_1	Rokon	Classic	1	5	1500	Brute		0.132	20	21	140.8	105.6	4.16	1.248	6.48	20000	0.285899935	0.03163950144	0.4695652174	0.07291666667	
	Special_2	Guzzi_V8	Special	2	0	1400	Concept		0.637	20	62	100.1	100.1	2.163	0.97	5.3	100000	0.02144249513	0.636864813	0.6405797101	0.5	
	Classic_2	Meaving	Classic	2	10	2500	Majesty		0.1365	20	23.25	145.6	109.2	4.12	1.261	6.36	20000	0.3170890188	0.03703259827	0.4869565217	0.09635416667	Electric
	Special_3	Sci_Fi_Bike	Special	3	0	1550	Comet		0.742	20	92	116.6	116.6	2.058	1.02	4.8	100000	0.1286549708	0.7627037392	0.7130434783	0.8125	Electric
	Special_4	Tron	Special	4	0	1750	Illuminator		0.636	20	92	243.8	174.9	2.058	1.122	4.8	100000	0.955165692	0.6356663471	0.7130434783	0.8125	Electric
	Special_5	Jet_Bike	Special	5	0	1950	Jet		0.7	20	80	110	110	2.1	1	5	100000	0.08576998051	0.7123681687	0.684057971	0.6875	
	Special_6	MonoBike	Special	6	0	2150	Mono		0.721	20	86	113.3	113.3	2.079	1.01	4.9	100000	0.1072124756	0.737535954	0.6985507246	0.75	
	Special_7	Shark	Special	7	0	2350	Shark		0.742	20	92	116.6	116.6	2.058	1.02	4.8	100000	0.1286549708	0.7627037392	0.7130434783	0.8125	
	Special_8	Bomb	Special	8	0	2575	Bomb		0.763	20	98	119.9	119.9	2.037	1.03	4.7	100000	0.1500974659	0.7878715244	0.7275362319	0.875	
	Special_9	Broomstick	Special	9	0	2800	Broomstick		0.784	20	104	123.2	123.2	2.016	1.04	4.6	100000	0.171539961	0.8130393097	0.7420289855	0.9375	
	Off-Road_1	Yamaha YZ 125	Off-Road	1	0	0	Slasher		0.88	30	35	118.8	79.2	1.56	1.056	3.24	1000	0.1429499675	0.9280920422	0.9391304348	0.21875	
	_	Yamaha MT-03 Black			0	0			0	0	0	0	0	0	0	0	0	-0.6289798571	-0.1265580058	1.408695652	-0.1458333333	
	Sport_1	Aprilia RS 125	Sport	1	0	0	Hellion		0.44	20	56	176	123.2	2.184	1.056	3.24	100000	0.514619883	0.4007670182	0.9391304348	0.4375	
	Street_1	Yamaha MT-03	Street	1	0	0	Voyage		0.44	20	35	167.2	114.4	2.288	0.96	4.32	50000	0.457439896	0.4007670182	0.7826086957	0.21875	
	Special_10	Monkey Bike	Special	10	0	3000	Monkey		0.805	20	110	126.5	126.5	1.995	1.05	4.5	100000	0.1929824561	0.8382070949	0.7565217391	1	
	Street_7	Augusta	Street	7	100	20000	Beast		0.53	20	57.5	201.4	137.8	2.156	1.02	3.84	50000	0.6796621183	0.5086289549	0.852173913	0.453125	
	Sport_2	Bimota	Sport	2	0	2500	Wolf		0.455	20	62	182	127.4	2.163	1.067	3.18	100000	0.5536062378	0.4187440077	0.947826087	0.5	
	Sport_3	Ninja	Sport	3	8	3000	Samurai		0.47	20	68	188	131.6	2.142	1.078	3.12	100000	0.5925925926	0.4367209971	0.9565217391	0.5625	
	Sport_7	Hayabusa	Sport	7	60	20000	Falcon		0.53	20	92	212	148.4	2.058	1.122	2.88	100000	0.7485380117	0.5086289549	0.9913043478	0.8125	
	Sport_4	GrazieVale Road Legal	Sport	4	12	3500	Axe		0.485	20	74	194	135.8	2.121	1.089	3.06	100000	0.6315789474	0.4546979866	0.9652173913	0.625	
	Sport_6	YZR_M1-2 Road Legal	Sport	6	40	10000	Ghost		0.515	20	86	206	144.2	2.079	1.111	2.94	100000	0.7095516569	0.4906519655	0.9826086957	0.75	
	Sport_	2018HondaVR46Moto2-2 Road Legal	Sport		0	675			0	0	0	0	0	0	0	0	0	-0.6289798571	-0.1265580058	1.408695652	-0.1458333333	
	_	Yamaha_R1			0	0			0	0	0	0	0	0	0	0	0	-0.6289798571	-0.1265580058	1.408695652	-0.1458333333	
	Sport_5	Ducati Panigale (vr46 Road Legal)	Sport	5	28	5000	Storm		0.5	20	80	200	140	2.1	1.1	3	100000	0.6705653021	0.472674976	0.9739130435	0.6875	
	Supersport_1	VR462	Supersport	1	0	2150	VR46		0.528	20	56	202.4	145.2	2.184	1.056	3.24	100000	0.6861598441	0.506232023	0.9391304348	0.4375	
	Supersport_2	Mooney VR46 Racing Team	Supersport	2	0	2350	Mooney VR46 Racing Team		0.546	20	62	209.3	150.15	2.163	1.067	3.18	100000	0.730994152	0.5278044104	0.947826087	0.5	
	Supersport_3	VR46 Riders Academy	Supersport	3	0	2575	VR46 Riders Academy		0.564	20	68	216.2	155.1	2.142	1.078	3.12	100000	0.77582846	0.5493767977	0.9565217391	0.5625	]]

local lines = spreadsheetData:split("\n")
local pets = {}

for _, line in lines do


--[[
	rarity
	gamepass
	name
	egg
	power
	exist
	
]]



	local rankStr = ""
	local name = ""
	local category = ""
	local rank = 0
	local level = 0
	local price = ""
	local gameName = ""

	local acceleration = 0
	local engineBrake = 0
	local brake = 0
	local maxSpeed = 0
	local turnSpeed = 0
	local leanM = 0
	local turnEXP = 0
	local turnM = 0
	local dampening = 0
	local uiAccel = 0
	local uiBrake = 0
	local uiHandle = 0
	local uiSpeed = 0
	local soundPack = nil

	local split = line:split("\t")

	local i = 1
	for _, str in split do
		if str == "" then
			continue
		end

		if i == 1 then
			rankStr = str
		elseif i == 2 then
			name = str
		elseif i == 3 then
			category = str
		elseif i == 4 then
			rank = tonumber(str)
		elseif i == 5 then
			level = tonumber(str)
		elseif i == 6 then
			price = tonumber(str)
		elseif i == 7 then
			gameName = str
		elseif i == 8 then
			acceleration = tonumber(str)
		elseif i == 9 then
			engineBrake = tonumber(str)
		elseif i == 10 then
			brake = tonumber(str)
		elseif i == 11 then
			maxSpeed = tonumber(str)
		elseif i == 12 then
			turnSpeed = tonumber(str)
		elseif i == 13 then
			leanM = tonumber(str)
		elseif i == 14 then
			turnEXP = tonumber(str)
		elseif i == 15 then
			turnM = tonumber(str)
		elseif i == 16 then
			dampening = tonumber(str)
		elseif i == 17 then
			uiSpeed = tonumber(str)
		elseif i == 18 then
			uiAccel = tonumber(str)
		elseif i == 19 then
			uiHandle = tonumber(str)
		elseif i == 20 then
			uiBrake = tonumber(str)
		elseif i == 21 then
			soundPack = str
		end

		i += 1
	end

	if gameName == "" then
		continue
	end

	if rankStr == "_" then
		continue
	end

	local handling = {
		acceleration = acceleration,
		engineBrake = engineBrake,
		brake = brake,
		maxSpeed = maxSpeed,
		turnSpeed = turnSpeed,
		leanM = leanM,
		turnEXP = turnEXP,
		turnM = turnM,
		dampening = dampening,
	}

	local uiStats = {
		["acceleration"] = uiAccel,
		["braking"] = uiBrake,
		["handling"] = uiHandle,
		["speed"] = uiSpeed,
	}

	if category == "Special" then
		level = 0
	end

	pets[name] = {
		name = name,
		category = category,
		rank = rank,
		level = level,
		price = price,
		gameName = gameName,
		gamepass = 0,
		handling = handling,
		uiStats = uiStats,
		soundPack = soundPack,
	}
end

-- local function sortByLevel(bike1, bike2)
-- 	if bike1.level ~= bike2.level then
-- 		return bike1.level < bike2.level
-- 	else
-- 		return bike1.price < bike2.price
-- 	end
-- end

-- table.sort(bikes, sortByLevel)

return pets