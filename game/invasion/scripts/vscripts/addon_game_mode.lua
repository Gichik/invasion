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

	PrecacheResource( "particle_folder", "particles/units/heroes/hero_witch_doctor/", context) --heal
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_oracle/", context) --heal
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_legion_commander", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_enigma", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_witchdoctor", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_bane", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_night_stalker", context )
	PrecacheResource( "particle_folder", "particles/units/heroes/hero_doom_bringer", context )


	PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_quills.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_bloody_mid.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal.vpcf", context )	
	PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf", context )	
	PrecacheResource( "particle", "particles/items_fx/healing_flask.vpcf", context )	
	PrecacheResource( "particle", "particles/econ/items/weaver/weaver_immortal_ti7/weaver_swarm_infected_debuff_ti7_ground_rings.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength_crit.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_clinkz/clinkz_strafe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf", context )
	PrecacheResource( "particle", "particles/generic_gameplay/generic_stunned.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal_flame.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_necrolyte/necrolyte_spirit_ground_aura.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_ghostship_marker_ripple.vpcf", context )
	PrecacheResource( "particle", "particles/items_fx/healing_clarity_c.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_ring.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal_b.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_explosion.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf", context )
	PrecacheResource( "particle", "particles/neutral_fx/satyr_hellcaller.vpcf", context ) -- fireball
	PrecacheResource( "particle", "particles/items2_fx/radiance_owner.vpcf", context ) -- burn
	PrecacheResource( "particle", "particles/items2_fx/radiance.vpcf", context ) -- burn
	PrecacheResource( "particle", "particles/neutral_fx/black_dragon_fireball.vpcf", context ) -- crushing_explosion
	PrecacheResource( "particle", "particles/econ/items/antimage/antimage_ti7_golden/antimage_blink_start_ti7_golden_flame.vpcf", context ) -- crushing_explosion
	PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf", context ) -- ice shards spear
	PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf", context ) -- ice shards spear
	PrecacheResource( "particle", "particles/units/heroes/hero_chen/chen_hand_of_god_fallback_mid.vpcf", context ) -- summoner_victim
	PrecacheResource( "particle", "particles/items2_fx/soul_ring_blood.vpcf", context ) -- dishonored_insidious
	PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf", context ) -- dishonored_counterattack
	PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context ) -- templar_blessing
	PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", context ) -- modifier_exile_highlander
	PrecacheResource( "particle", "particles/units/heroes/hero_pugna/pugna_netherblast_fluidexp.vpcf", context ) -- modifier_strychnine_dagger poison
	PrecacheResource( "particle", "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf", context ) -- modifier_strychnine_dagger
	PrecacheResource( "particle", "particles/world_destruction_fx/tree_dire_destroy.vpcf", context ) -- modifier_jeepers_trap_check
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_loadout.vpcf", context ) -- prophecy
	PrecacheResource( "particle", "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle_soft.vpcf", context ) -- vampire_sower_of_horror
	PrecacheResource( "particle", "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_trail_circle.vpcf", context ) -- vampire_sower_of_pain
	PrecacheResource( "particle", "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_debuff_echo_demo.vpcf", context ) -- vampire_sucking_life
	PrecacheResource( "particle", "particles/econ/items/omniknight/omni_ti8_head/omniknight_repel_buff_ti8_glyph.vpcf", context ) -- modifier_summoner_internal_power_buff
	PrecacheResource( "particle", "particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", context ) -- modifier_summoner_wide_swing
	PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf", context ) -- vampire
	PrecacheResource( "particle", "particles/items2_fx/soul_ring.vpcf", context ) --modif dung church
	PrecacheResource( "particle", "particles/items3_fx/lotus_orb_shell.vpcf", context ) --elementalist shield

	
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
