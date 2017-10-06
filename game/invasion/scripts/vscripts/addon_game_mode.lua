--[[
	Basic Barebones
]]

-- Required files to be visible from anywhere
require( 'timers' )
--require( 'barebones' )
require( 'invasion' )
require( 'invasion_in_the_forest' )
require( 'invasion_in_the_city' )
require( 'scorched_earth' )
require("statcollection/init")
require( 'invasion_td' )

if InvasionMode == nil then
	InvasionMode = class({})
end

function Precache( context )

	local pathToIG = LoadKeyValues("scripts/items/items_game.txt") -- загружаем весь файл

	PrecacheUnitByNameSync("sickly_zombies", context)
	PrecacheUnitByNameSync("npc_night", context)		
	InvasionMode:PrecacheForHero("npc_dota_hero_undying",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_life_stealer",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_alchemist",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_death_prophet",pathToIG,context)
	--InvasionMode:PrecacheForHero("npc_dota_hero_wisp",pathToIG,context)
	InvasionMode:PrecacheForHero("npc_dota_hero_rattletrap", pathToIG, context)
		
	-----------------------------moobs-----------------------------------
	
	PrecacheModel("models/heroes/necrolyte/necrolyte.vmdl", context) --necrolyte
	PrecacheModel("models/items/necrolyte/apostle_of_decay_weapon/apostle_of_decay_weapon.vmdl", context) --necrolyte weapon
	PrecacheModel("models/items/necrolyte/apostle_of_decay_head/apostle_of_decay_head.vmdl", context) --necrolyte helm
	PrecacheModel("models/items/necrolyte/apostle_of_decay_shoulder/apostle_of_decay_shoulder.vmdl", context) --necrolyte armor

	PrecacheModel("models/heroes/kunkka/kunkka.vmdl", context) --npc kunkka
	PrecacheModel("models/items/kunkka/pw_kraken_hat/kunkka_hair.vmdl", context) --npc kunkka helm
	PrecacheModel("models/items/kunkka/treds_of_the_kunkkistadore/treds_of_the_kunkkistadore.vmdl", context) --npc kunkka booots
	PrecacheModel("models/items/kunkka/green_sleeves_of_the_voyager/green_sleeves_of_the_voyager.vmdl", context) --npc kunkka gloves



	PrecacheModel("models/items/terrorblade/marauders_demon/marauders_demon.vmdl", context) --demon of hell
	PrecacheModel("models/heroes/warlock/warlock_demon.vmdl", context) --demon of hell
	PrecacheModel("models/items/warlock/golem/doom_of_ithogoaki/doom_of_ithogoaki.vmdl", context) --demon of hell	
	PrecacheModel("models/items/bane/slumbering_terror/slumbering_terror_nightmare_model.vmdl", context) --demon of hell


	PrecacheModel("models/items/broodmother/virulent_matriarchs_back/virulent_matriarchs_back.vmdl", context)	
	PrecacheModel("models/items/hex/sheep_hex/sheep_hex_gold.vmdl", context)
	PrecacheModel("models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context)
	PrecacheModel("models/props_structures/wood_post001.vmdl", context)
	PrecacheModel("models/heroes/shopkeeper_dire/shopkeeper_dire.vmdl", context) --shop
	PrecacheModel("models/heroes/death_prophet/death_prophet_ghost.vmdl", context) --also ghost


	PrecacheModel("models/props_structures/wood_wall004.vmdl", context) --wood wall	
	PrecacheModel("models/props_debris/wood_fence002.vmdl", context) --wood wall	


	PrecacheModel("models/props_tree/tree_cine_00_lowsmall.vmdl", context) --tree in forest	
	PrecacheModel("models/props_structures/mesh/classical_fountain001_destruction.vmdl", context) --fountain in forest		
	PrecacheModel("models/props_gameplay/tombstonea01.vmdl", context) --rip
	PrecacheModel("models/props_gameplay/tombstoneb01.vmdl", context) --rip
	PrecacheModel("models/items/wards/deadwatch_ward/deadwatch_ward.vmdl", context) --rip
	PrecacheModel("models/items/death_prophet/exorcism/hereticenclave/hereticenclave.vmdl", context) --rip
	PrecacheModel("models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_b.vmdl", context) --rip

	PrecacheModel("models/props_foliage/tree_pine01.vmdl", context) --night	

	PrecacheModel("models/items/undying/flesh_golem/corrupted_scourge_corpse_hive/corrupted_scourge_corpse_hive.vmdl", context) --city boss	
	PrecacheModel("models/props_debris/shop_set_cage001.vmdl", context) --cage	


	PrecacheModel("models/heroes/rattletrap/rattletrap.vmdl", context) --mech protector	
	PrecacheModel("models/items/rattletrap/forge_warrior_claw/forge_warrior_claw.vmdl", context) --mech protector
	PrecacheModel("models/items/rattletrap/forge_warrior_nipper/forge_warrior_nipper.vmdl", context) --mech protector	
	PrecacheModel("models/items/rattletrap/forge_warrior_helm/forge_warrior_helm.vmdl", context) --mech protector
	PrecacheModel("models/items/rattletrap/forge_warrior_rocket_cannon/forge_warrior_rocket_cannon.vmdl", context) --mech protector			
	PrecacheModel("models/items/rattletrap/forge_warrior_steam_exoskeleton/forge_warrior_steam_exoskeleton.vmdl", context) --mech protector			

	PrecacheModel("models/items/rattletrap/mechanised_pilgrim_cog/mechanised_pilgrim_cog.vmdl", context) --mech turret	
	PrecacheModel("models/props_gameplay/halloween_candy.vmdl", context)	--candy	

	PrecacheModel("models/heroes/beastmaster/beastmaster.vmdl", context) --beastmaster man	
	PrecacheModel("models/heroes/beastmaster/beastmaster_arms.vmdl", context) --beastmaster man
	PrecacheModel("models/heroes/beastmaster/beastmaster_belt.vmdl", context) --beastmaster man
	PrecacheModel("models/heroes/beastmaster/beastmaster_head.vmdl", context) --beastmaster man
	PrecacheModel("models/heroes/beastmaster/beastmaster_shoulder.vmdl", context) --beastmaster man
	PrecacheModel("models/heroes/beastmaster/beastmaster_weapon.vmdl", context) --beastmaster man

	-----------------------------td moobs-----------------------------------

	PrecacheModel("models/items/rattletrap/warmachine_cog_dc/warmachine_cog_dc.vmdl", context) --generator
	



	-----------------------------items-----------------------------------	
	PrecacheModel("models/props_gameplay/bottle_mango001.vmdl", context)	
	PrecacheModel("models/props_gameplay/gold_bag.vmdl", context) --bag of gold
	PrecacheModel("models/props_debris/battle_debris3.vmdl", context) --wood wall
	PrecacheModel("models/props_winter/present.vmdl", context) --present		
	
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

	PrecacheResource("particle", "particles/neutral_fx/ghost_base_attack.vpcf", context) --ghost attack

	PrecacheResource("particle", "particles/units/heroes/hero_tinker/tinker_missile.vpcf", context) --turret

	PrecacheResource("particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff_symbol.vpcf", context) --rubick
	PrecacheResource("particle_folder", "particles/units/heroes/hero_axe", context) --axe
	PrecacheResource("particle_folder", "particles/units/heroes/hero_bloodseeker", context) --axe	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_life_stealer", context) --axe	

	PrecacheResource("particle_folder", "particles/units/heroes/hero_faceless_void", context) --vengeful
	PrecacheResource("particle_folder", "particles/units/heroes/hero_enchantress", context) --enchantress
	PrecacheResource("particle_folder", "particles/units/heroes/hero_legion_commander", context) --skeleton king
	PrecacheResource("particle_folder", "particles/units/heroes/hero_kunkka", context) --skeleton king	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_phantom_assassin", context) --yurnero	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_pudge", context) --pudge
	PrecacheResource("particle_folder", "particles/units/heroes/hero_alchemist", context) --alchemist
	PrecacheResource("particle_folder", "particles/units/heroes/hero_skywrath_mage", context) --ghost
	PrecacheResource("particle_folder", "particles/units/heroes/hero_centaur/", context) --stomp

	PrecacheResource("particle_folder", "particles/units/heroes/hero_venomancer/", context) --viper
	PrecacheResource("particle_folder", "particles/units/heroes/hero_riki/", context) --assasin	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_slark/", context) --assasin
	PrecacheResource("particle_folder", "particles/units/heroes/hero_ogre_magi/", context) --ember, tinker
	PrecacheResource("particle_folder", "particles/units/heroes/hero_techies/", context) --tinker
	PrecacheResource("particle_folder", "particles/units/heroes/hero_beastmaster/", context) --man


	PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", context) --tesla
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", context) --shotgun
	PrecacheResource("particle", "particles/econ/events/league_teleport_2014/teleport_end_dust_league.vpcf", context) --shotgun
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", context) --demon of hell
	PrecacheResource("particle", "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", context) --quest

	PrecacheResource("particle", "particles/generic_gameplay/generic_sleep.vpcf", context) --sleep

	---------------------------------sounds-------------------------------
	PrecacheResource( "soundfile", "soundevents/invasion_sounds_custom.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_kunkka.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_riki.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rattletrap.vsndevts", context )
	--------------------------------------------------------------------------
	---------------------------------high light-------------------------------
	--------------------------------------------------------------------------	

	---------------------------------models-------------------------------
	PrecacheModel("models/items/bounty_hunter/back_jawtrap.vmdl", context)	--snap trap
	PrecacheModel("models/items/wards/blood_seeker_ward/bloodseeker_ward.vmdl", context)	--tombstone
	PrecacheModel("models/items/wards/portal_ward/portal_ward.vmdl", context)	--ward
	PrecacheModel("models/props_structures/tower_dragon_black.vmdl", context)	--tower
	

	PrecacheModel("models/heroes/treant_protector/treant_protector.vmdl", context)	--protector


	---------------------------------spells-------------------------------
	PrecacheResource("particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context) --snap trap
	PrecacheResource("particle", "particles/items_fx/dust_of_appearance.vpcf", context) --intent loock
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_rope.vpcf", context) --seed
	PrecacheResource("particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healing_ward_fortunes_tout_ward_gold_flame.vpcf", context) --heal
	PrecacheResource("particle", "particles/msg_fx/msg_damage.vpcf", context) --heal
	PrecacheResource("particle", "particles/units/heroes/hero_lion/lion_base_attack_glow.vpcf", context) --seed base attack

	PrecacheResource("particle_folder", "particles/units/heroes/hero_witch_doctor/", context) --heal
	PrecacheResource("particle_folder", "particles/units/heroes/hero_oracle/", context) --heal



	---------------------------------sounds------------------------------	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context ) --night		
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context ) --blink
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context ) --heal
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context ) --shotgun

	--------------------------------------------------------------------------
	---------------------------------ScorchedEarth----------------------------
	--------------------------------------------------------------------------

	---------------------------------models npc radiant-----------------------
	PrecacheModel("models/heroes/ember_spirit/ember_spirit.vmdl", context)	--npc_bartleby
	PrecacheModel("models/heroes/ember_spirit/arm.vmdl", context)	--npc_bartleby
	PrecacheModel("models/items/ember_spirit/blazearmor_weapon/blazearmor_weapon.vmdl", context)	--npc_bartleby

	PrecacheModel("models/heroes/antimage/antimage.vmdl", context)	--npc_cair
	PrecacheModel("models/heroes/antimage/antimage_chest.vmdl", context)	--npc_cair
	PrecacheModel("models/items/antimage/witch_hunter_head/witch_hunter_head.vmdl", context)	--npc_cair
	PrecacheModel("models/items/antimage/antimage_slasher_offhand_weapon.vmdl", context)	--npc_cair
	PrecacheModel("models/items/antimage/antimage_slasher_weapon.vmdl", context)	--npc_cair

	PrecacheModel("models/heroes/sven/sven.vmdl", context)	--npc_guts
	PrecacheModel("models/items/sven/helmet_of_tielong/helmet_of_tielong.vmdl", context)	--npc_guts
	PrecacheModel("models/items/sven/gauntlet_of_tielong/gauntlet_of_tielong.vmdl", context)	--npc_guts
	PrecacheModel("models/items/sven/sword_stone.vmdl", context)	--npc_guts
	PrecacheModel("models/items/sven/rhinoceros_back/rhinoceros_back.vmdl", context)	--npc_guts
	PrecacheModel("models/heroes/sven/sven_belt.vmdl", context)	--npc_guts

	PrecacheModel("models/heroes/bounty_hunter/bounty_hunter.vmdl", context)	--npc_louis
	PrecacheModel("models/heroes/bounty_hunter/bounty_hunter_lweapon.vmdl", context)	--npc_louis
	PrecacheModel("models/heroes/bounty_hunter/bounty_hunter_pads.vmdl", context)	--npc_louis

	---------------------------------models npc dire-----------------------
	PrecacheModel("models/heroes/lone_druid/lone_druid.vmdl", context)	--npc_loki
	PrecacheModel("models/heroes/lone_druid/weapon.vmdl", context)	--npc_loki

	PrecacheModel("models/heroes/beastmaster/beastmaster.vmdl", context)	--npc_merle
	PrecacheModel("models/heroes/beastmaster/beastmaster_belt.vmdl", context)	--npc_merle
	PrecacheModel("models/heroes/beastmaster/beastmaster_weapon.vmdl", context)	--npc_merle
	PrecacheModel("models/items/beastmaster/korosh_peaks_shoulder/korosh_peaks_shoulder.vmdl", context)	--npc_merle

	PrecacheModel("models/heroes/rattletrap/rattletrap.vmdl", context)	--npc_bender
	PrecacheModel("models/heroes/rattletrap/rattletrap_weapon.vmdl", context)	--npc_bender
	PrecacheModel("models/items/rattletrap/warmachine_head2_dc/warmachine_head2_dc.vmdl", context)	--npc_bender
	PrecacheModel("models/items/rattletrap/warmachine_shovel_dc/warmachine_shovel_dc.vmdl", context)	--npc_bender	
	
	PrecacheModel("models/heroes/omniknight/omniknight.vmdl", context)	--npc_redfield
	PrecacheModel("models/heroes/omniknight/head.vmdl", context)	--npc_redfield	
	PrecacheModel("models/items/omniknight/head_hood_hiero/head_hood_hiero.vmdl", context)	--npc_redfield	
	PrecacheModel("models/items/omniknight/cape_crusader.vmdl", context)	--npc_redfield	
	PrecacheModel("models/items/omniknight/weapon_feudal/weapon_feudal.vmdl", context)	--npc_redfield						

	---------------------------------models moobs-----------------------
	PrecacheModel("models/props_debris/basket002.vmdl", context)	--npc_rye
	PrecacheModel("models/heroes/juggernaut/jugg_healing_ward.vmdl", context)	--npc_rye
	
	PrecacheModel("models/items/hex/fish_hex/fish_hex.vmdl", context)	--npc_fish
	PrecacheModel("models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context)	--npc_skeleton
	PrecacheModel("models/heroes/undying/undying_minion.vmdl", context)	--npc_zombie	
	PrecacheModel("models/heroes/life_stealer/life_stealer.vmdl", context)	--npc_mad_zombie
	PrecacheModel("models/props_gameplay/crystal_ring01.vmdl", context)	--npc_burial_gold_chest

	---------------------------------models items-----------------------
	PrecacheModel("models/props_gameplay/treasure_chest001.vmdl", context)	--gold_chest	
	PrecacheModel("models/props_gameplay/recipe.vmdl", context)	--gold_map

	---------------------------------spells moobs-----------------------
	PrecacheResource("particle_folder", "particles/units/heroes/hero_treant", context) --dead witch	
	PrecacheResource("particle_folder", "particles/units/heroes/hero_witchdoctor", context) --dead witch

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

if MapName == "invasion_in_the_city_small" then
	print("------------------------------------invasion city-------------------------------------")	
	InvasionMode:CityMap()		
end

if MapName == "scorched_earth" then
	print("------------------------------------scorched earth-------------------------------------")	
	InvasionMode:ScorchedEarthMap()		
end

if MapName == "test" then
	print("------------------------------------invasion td-------------------------------------")	
	InvasionMode:TDMap()	
end

end

-- Quest entity that will contain the quest data so it can be referenced later
local EntQuestEnch = nil


-- Call this function from Hammer to start the quest.  Checks to see if the entity has been created, if not, create the entity
-- See "adventure_example.vmap" for syntax on accessing functions
function QuestEnchStart()
	--print("QuestEnchStart")
	if EntQuestEnch == nil then
		EntQuestEnch = SpawnEntityFromTableSynchronous( "quest", { name = "QuestEnch", title = "#QuestEnch_title" } )
		print("Quest")
	end
end


-- Call this function to end the quest.  References the previously created quest if it has been created, if not, should do nothing
function QuestEnchComplete()
	--print("QuestEnchComplete")
	if EntQuestEnch ~= nil then
		EntQuestEnch:CompleteQuest()
		GameRules:SetGoldPerTick( 2 )
		local unit = Entities:FindByName(nil, "QuestEnch_NPC")
		unit:AddNoDraw()
		unit:ForceKill(false)

		local point = Entities:FindByName( nil, "spawn_enchantress"):GetAbsOrigin()
		unit = CreateUnitByName("npc_enchantress_base", point, true, nil, nil, DOTA_TEAM_GOODGUYS )	
		unit:SetForwardVector(Vector(0,-1,0))
	end
end

function QuestEnchFail()
	--print("QuestEnchFail")
	if EntQuestEnch ~= nil then
		EntQuestEnch:CompleteQuest()
	end
end