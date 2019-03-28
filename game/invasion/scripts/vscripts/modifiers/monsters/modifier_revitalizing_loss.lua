
if modifier_revitalizing_loss == nil then
    modifier_revitalizing_loss = class({})
end

function modifier_revitalizing_loss:GetModifierAura()
    return "modifier_revitalizing_loss_buff"
end

function modifier_revitalizing_loss:IsHidden()
	return false
end

function modifier_revitalizing_loss:RemoveOnDeath()
	return true
end

function modifier_revitalizing_loss:CanBeAddToMinions()
    return true
end

function modifier_revitalizing_loss:IsPurgable()
    return false
end

function modifier_revitalizing_loss:IsPurgeException()
    return false
end

function modifier_revitalizing_loss:IsAura()
    return true
end

function modifier_revitalizing_loss:GetAuraRadius()
    return self.auraRadius
end

function modifier_revitalizing_loss:GetTexture()
    return "undying_soul_rip"
end

--function modifier_revitalizing_loss:GetEffectName()
   --return "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf"
--end

function modifier_revitalizing_loss:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_revitalizing_loss:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_revitalizing_loss:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_revitalizing_loss:GetAuraDuration()
    return self.auraDuration
end

function modifier_revitalizing_loss:OnCreated()
    self.auraRadius = 600
    self.auraDuration = 0.5

	if IsServer() then
		self:GetParent():SetRenderColor(144, 238, 144)
	end
end


--------------------------------------------------------------------------------

modifier_revitalizing_loss_buff = class({})

function modifier_revitalizing_loss_buff:DeclareFunctions()
        local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function modifier_revitalizing_loss_buff:GetModifierConstantHealthRegen()
    return self.hpRegenBonus
end


function modifier_revitalizing_loss_buff:GetTexture()
    return "undying_soul_rip"
end

function modifier_revitalizing_loss_buff:OnCreated()
    self.hpRegenBonus = 30
end

function modifier_revitalizing_loss_buff:GetEffectName()
    return "particles/items_fx/healing_flask.vpcf"
end

function modifier_revitalizing_loss_buff:IsHidden()
    return false
end

function modifier_revitalizing_loss_buff:RemoveOnDeath()
    return true
end