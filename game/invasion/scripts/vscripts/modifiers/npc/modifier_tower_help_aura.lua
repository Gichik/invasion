
if modifier_tower_help_aura == nil then
    modifier_tower_help_aura = class({})
end

function modifier_tower_help_aura:IsHidden()
    return true
end

function modifier_tower_help_aura:RemoveOnDeath()
	return true
end

function modifier_tower_help_aura:IsPurgable()
    return false
end

function modifier_tower_help_aura:IsPurgeException()
    return false
end

function modifier_tower_help_aura:IsAura()
    return true
end

function modifier_tower_help_aura:GetModifierAura()
    return "modifier_tower_help_aura_buff"
end

function modifier_tower_help_aura:GetAuraRadius()
    return self.auraRadius
end

function modifier_tower_help_aura:GetTexture()
    return "puck_waning_rift"
end


function modifier_tower_help_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_tower_help_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--[[
function modifier_tower_help_aura:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end]]

function modifier_tower_help_aura:GetAuraDuration()
    return self.auraDuration
end

function modifier_tower_help_aura:OnCreated()
    --self.auraRadius = self:GetAbility():GetSpecialValueFor("aura_radius") or 500
    self.auraRadius = 1000
    self.auraDuration = 0.5
end

--------------------------------------------------------------------------------

modifier_tower_help_aura_buff = class({})

function modifier_tower_help_aura_buff:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_tower_help_aura_buff:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
    end
    return 0 
end

function modifier_tower_help_aura_buff:GetModifierConstantManaRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_mp_regen")
    end
    return 0         
end

function modifier_tower_help_aura_buff:GetTexture()
    return "puck_illusory_orb"
end

function modifier_tower_help_aura_buff:GetEffectName()
    return "particles/items_fx/healing_flask.vpcf"
end

function modifier_tower_help_aura_buff:IsHidden()
    return false
end

function modifier_tower_help_aura_buff:RemoveOnDeath()
    return true
end

function modifier_tower_help_aura_buff:IsPurgable()
    return false
end

function modifier_tower_help_aura_buff:IsPurgeException()
    return false
end