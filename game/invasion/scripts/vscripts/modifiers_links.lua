LinkLuaModifier("modifier_octarinius", "modifiers/modifier_octarinius.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_ghost_evasion", "modifiers/modifier_ghost_evasion.lua", LUA_MODIFIER_MOTION_NONE )


LinkLuaModifier("modifier_iron_head", "modifiers/modifier_iron_head.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_rabid_giggles", "modifiers/modifier_rabid_giggles.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_love", "modifiers/modifier_love.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_bodybuilder", "modifiers/modifier_bodybuilder.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_strange_man", "modifiers/modifier_strange_man.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_nudity", "modifiers/modifier_nudity.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_critic", "modifiers/modifier_critic.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_fat_ass", "modifiers/modifier_fat_ass.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_cunning", "modifiers/modifier_cunning.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_quest_absorption", "modifiers/modifier_quest_absorption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_apply_phys_dmg", "modifiers/modifier_quest_apply_phys_dmg.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_apply_mag_dmg", "modifiers/modifier_quest_apply_mag_dmg.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_kill_sicklyZ", "modifiers/modifier_quest_kill_sicklyZ.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_kill_tightZ", "modifiers/modifier_quest_kill_tightZ.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_kill_halfZ", "modifiers/modifier_quest_kill_halfZ.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_kill_some_units", "modifiers/modifier_quest_kill_some_units.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier("modifier_quest_heal", "modifiers/modifier_quest_heal.lua", LUA_MODIFIER_MOTION_NONE )


---------------------------------td modifiers-------------------------------
--LinkLuaModifier("modifier_apply_energy_intensity", "modifiers/td_modifiers/modifier_apply_energy_intensity.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier("modifier_jewel_energy_intensity", "modifiers/td_modifiers/modifier_jewel_energy_intensity.lua", LUA_MODIFIER_MOTION_NONE )
----------------------------------------------------------------------------

function GetQuestModifierName()
	local ModifName = {	"modifier_quest_absorption",
						"modifier_quest_apply_phys_dmg",
						"modifier_quest_apply_mag_dmg",
						"modifier_quest_kill_sicklyZ",
						"modifier_quest_kill_tightZ",
						"modifier_quest_kill_halfZ",
						"modifier_quest_kill_some_units"}						
	return ModifName[RandomInt(1,#ModifName)]
end

function ChekQuestModifier(player)
	local ModifierName = {	"modifier_quest_absorption",
						"modifier_quest_apply_phys_dmg",
						"modifier_quest_apply_mag_dmg",
						"modifier_quest_kill_sicklyZ",
						"modifier_quest_kill_tightZ",
						"modifier_quest_kill_halfZ",
						"modifier_quest_kill_some_units"}
	local bHasModifier = false

	for i=1, #ModifierName do
		bHasModifier = player:HasModifier(ModifierName[i])
		if bHasModifier then
			return true
		end
	end

	return false
end
