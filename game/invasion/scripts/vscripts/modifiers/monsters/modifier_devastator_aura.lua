
if modifier_devastator_aura == nil then
    modifier_devastator_aura = class({})
end

function modifier_devastator_aura:GetModifierAura()
    return "modifier_devastator_aura_debuff"
end

function modifier_devastator_aura:IsHidden()
	return false
end

function modifier_devastator_aura:RemoveOnDeath()
	return true
end

function modifier_devastator_aura:CanBeAddToMinions()
    return true
end

function modifier_devastator_aura:IsPurgable()
    return false
end

function modifier_devastator_aura:IsPurgeException()
    return false
end

function modifier_devastator_aura:IsAura()
    return true
end

function modifier_devastator_aura:GetAuraRadius()
    return self.auraRadius
end

function modifier_devastator_aura:GetTexture()
    return "naga_siren_song_of_the_siren_cancel"
end

function modifier_devastator_aura:GetEffectName()
    --return "particles/custom/aura_command.vpcf"
end

function modifier_devastator_aura:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_devastator_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_devastator_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_devastator_aura:GetAuraDuration()
    return self.auraDuration
end

function modifier_devastator_aura:OnCreated()
    self.auraRadius = 600
    self.auraDuration = 0.3

	if IsServer() then
		self:GetParent():SetRenderColor(176, 196, 222)
	end
end

--------------------------------------------------------------------------------

modifier_devastator_aura_debuff = class({})

function modifier_devastator_aura_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_IGNORE_PHYSICAL_ARMOR }
end

function modifier_devastator_aura_debuff:GetModifierIgnorePhysicalArmor()	
	return 1
end

function modifier_devastator_aura_debuff:GetTexture()
    return "naga_siren_song_of_the_siren_cancel"
end

function modifier_devastator_aura_debuff:IsHidden()
    return false
end

function modifier_devastator_aura_debuff:RemoveOnDeath()
    return true
end

function modifier_devastator_aura_debuff:GetEffectName()
    return "particles/econ/items/weaver/weaver_immortal_ti7/weaver_swarm_infected_debuff_ti7_ground_rings.vpcf"
end