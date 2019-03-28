
if modifier_weakness_aura == nil then
    modifier_weakness_aura = class({})
end

function modifier_weakness_aura:GetModifierAura()
    return "modifier_weakness_aura_debuff"
end

function modifier_weakness_aura:IsHidden()
	return false
end

function modifier_weakness_aura:RemoveOnDeath()
	return true
end

function modifier_weakness_aura:CanBeAddToMinions()
    return true
end

function modifier_weakness_aura:IsPurgable()
    return false
end

function modifier_weakness_aura:IsPurgeException()
    return false
end

function modifier_weakness_aura:IsAura()
    return true
end


function modifier_weakness_aura:GetAuraRadius()
    return self.auraRadius
end

function modifier_weakness_aura:GetTexture()
    return "visage_grave_chill"
end

function modifier_weakness_aura:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_weakness_aura:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_weakness_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_weakness_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_weakness_aura:GetAuraDuration()
    return self.auraDuration
end

function modifier_weakness_aura:OnCreated()
    self.auraRadius = 600
    self.auraDuration = 0.3

	if IsServer() then
		self:GetParent():SetRenderColor(70, 130, 180)
	end
end

function modifier_weakness_aura:OnDestroy()
	if IsServer() then

	end
end

--------------------------------------------------------------------------------

modifier_weakness_aura_debuff = class({})

function modifier_weakness_aura_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end

function modifier_weakness_aura_debuff:GetModifierAttackSpeedBonus_Constant()	
	return -60
end

function modifier_weakness_aura_debuff:GetTexture()
    return "visage_grave_chill"
end

function modifier_weakness_aura_debuff:IsHidden()
    return false
end

function modifier_weakness_aura_debuff:RemoveOnDeath()
    return true
end

function modifier_weakness_aura_debuff:GetEffectName()
    return "particles/econ/items/bounty_hunter/bounty_hunter_hunters_hoard/bounty_hunter_hoard_track_trail_circle.vpcf"
end
