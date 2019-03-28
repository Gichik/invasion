--[[
	Basic Barebones
]]

-- Required files to be visible from anywhere
require( 'timers' )
--require( 'barebones' )
require( 'invasion_classic' )
require( 'invasion_armageddon' )
require( 'triggers' )
require( 'modifiers_links' )
require( 'constant_links' )
--require( 'invasion_in_the_forest' )
--require( 'invasion_in_the_city' )
--require( 'scorched_earth' )
--require("statcollection/init")
--require( 'invasion_td' )

if InvasionMode == nil then
	InvasionMode = class({})
end

function Precache( context )

	---------------------------------model-------------------------------
	PrecacheModel("models/props_gameplay/pig.vmdl", context) --pig
	PrecacheModel("models/items/hex/sheep_hex/sheep_hex.vmdl", context) --sheep

	PrecacheModel("models/heroes/undying/undying_minion_torso.vmdl", context) --half zombie
	PrecacheModel("models/heroes/undying/undying_minion.vmdl", context) -- zombie
	PrecacheModel("models/heroes/life_stealer/life_stealer.vmdl", context) -- ghoul
	PrecacheModel("models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context) -- ghost
	PrecacheModel("models/heroes/undying/undying_flesh_golem.vmdl", context) -- undying mutant


	PrecacheModel("models/props_structures/radiant_tower001.vmdl", context) -- tower
	PrecacheModel("models/props_structures/tower_upgrade/tower_upgrade.vmdl", context) -- tower
	PrecacheModel("models/buildings/building_racks_ranged_reference.vmdl", context) -- tower
	PrecacheModel("models/buildings/building_racks_melee_reference.vmdl", context) -- tower
	PrecacheModel("models/props_gameplay/gold_bag.vmdl", context) -- gold bags

	PrecacheModel("models/creeps/neutral_creeps/n_creep_jungle_stalker/n_creep_gargoyle_jungle_stalker.vmdl", context) -- armageddon boss
	PrecacheModel("models/items/dragon_knight/ti8_dk_third_awakening_dragon/ti8_dk_third_awakening_dragon.vmdl", context) -- armageddon boss



--models/props_structures/tower_upgrade/tower_upgrade.vmdl
--models/props_structures/tower001.vmdl


	---------------------------------spells-------------------------------
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", context) --blood
	PrecacheResource("particle", "particles/generic_gameplay/generic_hit_blood.vpcf", context) --blood
	PrecacheResource("particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context) --blood

	PrecacheResource("particle_folder", "particles/units/heroes/hero_witch_doctor/", context) --heal
	PrecacheResource("particle_folder", "particles/units/heroes/hero_oracle/", context) --heal

	---------------------------------sounds-------------------------------
	PrecacheResource( "soundfile", "soundevents/invasion_sounds_custom.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context )


	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bristleback.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )

	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context )		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context )		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )



	---------------------------------------
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_grimstroke", context )
	PrecacheResource("particle", "particles/units/heroes/hero_grimstroke/grimstroke_loadout.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_demonartist/demonartist_darkartistry_proj.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_demonartist/demonartist_darkartistry_dmg_stroke_tgt.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_demonartist/demonartist_darkartistry_dmg_steam.vpcf", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context )


end


function Activate()
	--GameRules.GameMode = GameMode()
	InvasionMode:InitInvasionMode()
end

 
function InvasionMode:InitInvasionMode()

	local MapName = GetMapName()
	print(MapName)

	if MapName == "invasion_classic" then
	print("----------------------------------------invasion Start----------------------------------------")	
	InvasionMode:InvasionMap()
	end

	if MapName == "invasion_armageddon" then
	print("----------------------------------------Armageddon Start----------------------------------------")	
	ArmageddonMode:Settings()
	end

end
