

if modifier_apply_energy_intensity == nil then
	modifier_apply_energy_intensity = class({})
end
LinkLuaModifier("modifier_energy_intensity", "modifiers/td_modifiers/modifier_apply_energy_intensity.lua", LUA_MODIFIER_MOTION_NONE )

function modifier_apply_energy_intensity:GetTexture()
    return "td_ability/tower_energy_intensity"
end

function modifier_apply_energy_intensity:IsAura()
    return true
end


function modifier_apply_energy_intensity:GetAuraRadius()
    return 1000
end

function modifier_apply_energy_intensity:GetModifierAura()
    return "modifier_energy_intensity"
end

function modifier_apply_energy_intensity:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_apply_energy_intensity:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC
end

function modifier_apply_energy_intensity:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

if modifier_energy_intensity == nil then
	modifier_energy_intensity = class({})
end

function modifier_energy_intensity:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_energy_intensity:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end

function modifier_energy_intensity:GetTexture()
    return "td_ability/tower_energy_intensity"
end


function modifier_energy_intensity:GetModifierConstantManaRegen()
		return -10
end


function modifier_energy_intensity:RemoveOnDeath()
	return true
end

function modifier_energy_intensity:IsBuff()
    return true
end

function modifier_energy_intensity:IsHidden()
    return true
end