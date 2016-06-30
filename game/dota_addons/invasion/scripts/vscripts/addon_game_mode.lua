--[[
	Basic Barebones
]]

-- Required files to be visible from anywhere
require( 'timers' )
--require( 'barebones' )
require( 'invasion' )
require( 'invasion_old' )
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
	
	-----------------------------moobs-----------------------------------
	PrecacheModel("models/items/broodmother/virulent_matriarchs_back/virulent_matriarchs_back.vmdl", context)	
	PrecacheModel("models/items/hex/sheep_hex/sheep_hex_gold.vmdl", context)
	PrecacheModel("models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context)
	PrecacheModel("models/props_structures/wood_post001.vmdl", context)
	PrecacheModel("models/heroes/shopkeeper_dire/shopkeeper_dire.vmdl", context) --shop
	PrecacheModel("models/heroes/death_prophet/death_prophet_ghost.vmdl", context) --also ghost

	PrecacheResource("particle", "particles/neutral_fx/ghost_base_attack.vpcf", context) --ghost attack

	-----------------------------items-----------------------------------	
	PrecacheModel("models/props_gameplay/bottle_mango001.vmdl", context)	
	PrecacheModel("models/props_gameplay/gold_bag.vmdl", context) --bag of gold
	
	---------------------------------spells-------------------------------
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", context) --blood
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_tinker", context ) --tinker
	
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) --blood
	PrecacheResource("particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context) --blood
	PrecacheResource("particle", "particles/dire_fx/tower_bad_face_end_glow.vpcf", context) --omni
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine_ball_explosion.vpcf", context) --omni
	PrecacheResource("particle", "particles/dire_fx/tower_bad_face_end_ball.vpcf", context) --omni
	
	PrecacheResource("particle", "particles/customgames/capturepoints/cp_allied_wind.vpcf", context) --rubick	
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames_heal.vpcf", context) --rubick
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal.vpcf", context) --rubick
	
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_start_sparks.vpcf", context) --rubick
	PrecacheResource("particle", "particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_split_sparks_tormented.vpcf", context) --rubick
	PrecacheResource("particle", "particles/customgames/capturepoints/msg_capturepoints_allied.vpcf", context) --rubick
	PrecacheResource("particle", "particles/econ/items/rubick/rubick_force_ambient/rubick_telekinesis_force_cube.vpcf", context) --rubick
	PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_telekinesis_impact_rings.vpcf", context) --rubick

	PrecacheResource("particle", "particles/addons_gameplay/tower_good_tintable_lamp_end_core.vpcf", context) --rubick

	PrecacheResource("particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff_symbol.vpcf", context) --rubick
	PrecacheResource("particle_folder", "particles/units/heroes/hero_axe", context) --axe
	PrecacheResource("particle_folder", "particles/units/heroes/hero_bloodseeker", context) --axe	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_life_stealer", context) --axe	

	PrecacheResource("particle_folder", "particles/units/heroes/hero_faceless_void", context) --vengeful
	
	---------------------------------sounds-------------------------------
	PrecacheResource( "soundfile", "soundevents/invasion_sounds_custom.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context )
	
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
print(MapName)

if MapName == "invasion" then
	print("----------------------------------------invasion Start----------------------------------------")	
	print(MapName)
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
	print("------------------------------------invasion forest PvP Start-------------------------------------")	
	InvasionMode:InvasionForestPvPMap()		
end


end


