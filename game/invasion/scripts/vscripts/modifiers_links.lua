


LinkLuaModifier("modifier_devourer_classic", "modifiers/modifier_devourer_classic.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_elusive_classic", "modifiers/modifier_elusive_classic.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_dismemberment", "modifiers/modifier_dismemberment.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_laceration", "modifiers/modifier_laceration.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_reflector_bosses", "modifiers/modifier_reflector_bosses.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aura_of_death", "modifiers/modifier_aura_of_death.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aura_of_death_debuff", "modifiers/modifier_aura_of_death.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_hommer_cry", "modifiers/modifier_hommer_cry.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_attack_of_deactivating", "modifiers/modifier_attack_of_deactivating.lua", LUA_MODIFIER_MOTION_NONE )



LinkLuaModifier("modifier_range_magick_attack", "modifiers/monsters/modifier_range_magick_attack.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_no_health_bar", "modifiers/monsters/modifier_no_health_bar.lua", LUA_MODIFIER_MOTION_NONE )
-------------------------------------------------------------------
-------------------------MONSTER NPC--------------------------
-------------------------------------------------------------------
LinkLuaModifier("modifier_tower_help_aura", "modifiers/npc/modifier_tower_help_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tower_help_aura_buff", "modifiers/npc/modifier_tower_help_aura.lua", LUA_MODIFIER_MOTION_NONE )

-------------------------------------------------------------------
-------------------------MONSTER MODIFIER--------------------------
-------------------------------------------------------------------

LinkLuaModifier("modifier_giant", "modifiers/monsters/modifier_giant.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_frantic", "modifiers/monsters/modifier_frantic.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_thorns", "modifiers/monsters/modifier_thorns.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_distortion_carrier", "modifiers/monsters/modifier_distortion_carrier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_lump", "modifiers/monsters/modifier_lump.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_elusive", "modifiers/monsters/modifier_elusive.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_reflector", "modifiers/monsters/modifier_reflector.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_explosive", "modifiers/monsters/modifier_explosive.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_insane", "modifiers/monsters/modifier_insane.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_devourer", "modifiers/monsters/modifier_devourer.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_breaking_bone", "modifiers/monsters/modifier_breaking_bone.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_stunned", "modifiers/monsters/modifier_stunned.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_weakness_aura", "modifiers/monsters/modifier_weakness_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_weakness_aura_debuff", "modifiers/monsters/modifier_weakness_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_cursed_aura", "modifiers/monsters/modifier_cursed_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_cursed_aura_buff", "modifiers/monsters/modifier_cursed_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_unity_of_evil", "modifiers/monsters/modifier_unity_of_evil.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_unity_of_evil_mark", "modifiers/monsters/modifier_unity_of_evil.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_pest_aura", "modifiers/monsters/modifier_pest_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_pest_aura_debuff", "modifiers/monsters/modifier_pest_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_revitalizing_loss", "modifiers/monsters/modifier_revitalizing_loss.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_revitalizing_loss_buff", "modifiers/monsters/modifier_revitalizing_loss.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_devastator_aura", "modifiers/monsters/modifier_devastator_aura.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_devastator_aura_debuff", "modifiers/monsters/modifier_devastator_aura.lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier("modifier_circulator_infection", "modifiers/monsters/modifier_circulator_infection.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_circulator_infection_debuff", "modifiers/monsters/modifier_circulator_infection.lua", LUA_MODIFIER_MOTION_NONE )



-------------------------------------------------------------------

function GetRandomModifierName()
	local ModifName = {	"modifier_giant",
						"modifier_frantic",
						"modifier_thorns",
						"modifier_distortion_carrier",
						"modifier_lump",
						"modifier_elusive",
						"modifier_reflector",
						"modifier_explosive",
						"modifier_insane",
						"modifier_devourer",
						"modifier_breaking_bone",
						"modifier_weakness_aura",
						"modifier_cursed_aura",
						"modifier_unity_of_evil",
						"modifier_pest_aura",
						"modifier_revitalizing_loss",
						"modifier_devastator_aura",
						"modifier_circulator_infection"
						}						
	return ModifName[RandomInt(1,#ModifName)]
end
