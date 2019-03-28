
if modifier_cursed_aura == nil then
    modifier_cursed_aura = class({})
end

function modifier_cursed_aura:GetModifierAura()
    return "modifier_cursed_aura_buff"
end

function modifier_cursed_aura:IsHidden()
	return false
end

function modifier_cursed_aura:RemoveOnDeath()
	return true
end

function modifier_cursed_aura:CanBeAddToMinions()
    return false
end

function modifier_cursed_aura:IsPurgable()
    return false
end

function modifier_cursed_aura:IsPurgeException()
    return false
end


function modifier_cursed_aura:IsAura()
    return true
end

function modifier_cursed_aura:GetAuraRadius()
    return self.auraRadius
end

function modifier_cursed_aura:GetTexture()
    return "doom_bringer_doom"
end

--function modifier_cursed_aura:GetEffectName()
--   return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf"
--end

function modifier_cursed_aura:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_cursed_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_cursed_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_cursed_aura:GetAuraDuration()
    return self.auraDuration
end

function modifier_cursed_aura:GetAuraEntityReject(target)
    if (target == self:GetCaster()) then
        return true
    end
    return false
end

function modifier_cursed_aura:OnCreated()
    self.auraRadius = 600
    self.auraDuration = 0.5

	if IsServer() then
		self:GetParent():SetRenderColor(0, 0, 0)
        self:GetParent():SetModelScale(1.0)
	end
end


--------------------------------------------------------------------------------

modifier_cursed_aura_buff = class({})

function modifier_cursed_aura_buff:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
    return funcs
end

function modifier_cursed_aura_buff:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_cursed_aura_buff:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_cursed_aura_buff:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_cursed_aura_buff:GetTexture()
    return "doom_bringer_doom"
end

function modifier_cursed_aura_buff:OnCreated()
    if IsServer() then
        self:GetParent():SetRenderColor(0, 0, 0)
    end
end

function modifier_cursed_aura_buff:GetEffectName()
    return "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf"
end

function modifier_cursed_aura_buff:IsHidden()
    return false
end

function modifier_cursed_aura_buff:RemoveOnDeath()
    return true
end

function modifier_cursed_aura_buff:OnDestroy()
    if IsServer() then
        self:GetParent():SetRenderColor(255, 255, 255)
    end
end