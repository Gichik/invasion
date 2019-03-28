
if modifier_pest_aura == nil then
    modifier_pest_aura = class({})
end

function modifier_pest_aura:GetModifierAura()
    return "modifier_pest_aura_debuff"
end

function modifier_pest_aura:IsHidden()
	return false
end

function modifier_pest_aura:RemoveOnDeath()
	return true
end

function modifier_pest_aura:CanBeAddToMinions()
    return true
end

function modifier_pest_aura:IsPurgable()
    return false
end

function modifier_pest_aura:IsPurgeException()
    return false
end

function modifier_pest_aura:IsAura()
    return true
end

function modifier_pest_aura:GetAuraRadius()
    return self.auraRadius
end

function modifier_pest_aura:GetTexture()
    return "warlock_upheaval"
end

function modifier_pest_aura:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_pest_aura:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pest_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_pest_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_pest_aura:GetAuraDuration()
    return self.auraDuration
end

function modifier_pest_aura:OnCreated()
    self.auraRadius = 600
    self.auraDuration = 0.3

	if IsServer() then
		self:GetParent():SetRenderColor(128, 128, 0)
	end
end

function modifier_pest_aura:OnDestroy()
	if IsServer() then

	end
end

--------------------------------------------------------------------------------

modifier_pest_aura_debuff = class({})

function modifier_pest_aura_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end

function modifier_pest_aura_debuff:GetModifierMoveSpeedBonus_Constant()	
	return -150
end

function modifier_pest_aura_debuff:GetTexture()
    return "warlock_upheaval"
end

function modifier_pest_aura_debuff:IsHidden()
    return false
end

function modifier_pest_aura_debuff:RemoveOnDeath()
    return true
end

function modifier_pest_aura_debuff:GetEffectName()
    return "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff.vpcf"
end
