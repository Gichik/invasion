--[[
	Basic Barebones
]]

-- Required files to be visible from anywhere
require( 'timers' )
--require( 'barebones' )
require( 'invasion' )
require( 'invasion_in_the_forest' )
require( 'invasion_forest_pvz' )
require( 'invasion_forest_pvp' )




if InvasionMode == nil then
	InvasionMode = class({})
end

function Precache( context )

	local pathToIG = LoadKeyValues("scripts/items/items_game.txt") -- загружаем весь файл

	PrecacheUnitByNameSync("sickly_zombies", context)	
	InvasionMode:PrecacheForHero("npc_dota_hero_undying",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_life_stealer",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_alchemist",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_death_prophet",pathToIG,context)
	
	
end

function InvasionMode:PrecacheForHero(name,path,context)


print("----------------------------------------Precache Start----------------------------------------")

	local wearablesList = {} --переменная для надеваемых шмоток(для всех героев)
	local precacheWearables = {} --переменная только для шмоток нужного героя
	local precacheParticle = {}
	for k, v in pairs(path) do
		if k == 'items' then
			wearablesList = v
		end
	end
	local counter = 0
	local counter_particle = 0
	local value
	for k, v in pairs(wearablesList) do -- выбираем из списка предметов только предметы на нужных героев
		if InvasionMode:IsForHero(name, wearablesList[k]) then
			if wearablesList[k]["model_player"] then
				value = wearablesList[k]["model_player"] 
				precacheWearables[value] = true
			end
			if wearablesList[k]["particle_file"] then -- прекешируем еще и частицы, куда ж без них!
				value = wearablesList[k]["particle_file"] 
				precacheParticle[value] = true
			end
		end
	end

	for wearable,_ in pairs( precacheWearables ) do --собственно само прекеширование всех занесенных в список шмоток
		print("Precache model: " .. wearable)
		PrecacheResource( "model", wearable, context )
		counter = counter + 1
	end

	for wearable,_ in pairs( precacheParticle) do --и прекеширование частиц
		print("Precache particle: " .. wearable)
		PrecacheResource( "particle", wearable, context )
		counter_particle = counter_particle + 1

	end

	PrecacheUnitByNameSync(name, context) -- прекешируем саму модель героя! иначе будут бегать шмотки без тела
		
    print('[Precache]' .. counter .. " models loaded and " .. counter_particle .." particles loaded")
	print('[Precache] End')

end

function InvasionMode:IsForHero(str, tbl)
	if type(tbl["used_by_heroes"]) ~= type(1) and tbl["used_by_heroes"] then -- привет от вашего друга, индийского быдлокодера работающего за еду
		if tbl["used_by_heroes"][str] then
			return true
		end
	end
	return false
end


function Activate()
	--GameRules.GameMode = GameMode()
	InvasionMode:InitInvasionMode()
end
 
 
 

 
function InvasionMode:InitInvasionMode()


local MapName = GetMapName()

if MapName == "invasion" then
	print("----------------------------------------invasion Start----------------------------------------")	
	InvasionMode:InvasionMap()
end

if MapName == "invasion_in_the_forest" then
	print("------------------------------------invasion in the forest Start-------------------------------------")	
	InvasionMode:InvasionITForestMap()	
end

if MapName == "invasion_forest_pvz" then
	print("------------------------------------invasion forest PvZ Start-------------------------------------")	
	InvasionMode:InvasionForestPvZMap()		
end

if MapName == "pvp_invasion_forest" then
	print("------------------------------------invasion forest PvZ Start-------------------------------------")	
	InvasionMode:InvasionForestPvPMap()		
end


end


