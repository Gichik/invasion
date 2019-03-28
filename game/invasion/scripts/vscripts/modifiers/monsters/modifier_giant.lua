
if modifier_giant == nil then
    modifier_giant = class({})
end

function modifier_giant:IsHidden()
	return false
end

function modifier_giant:GetTexture()
    return "beastmaster_primal_roar"
end

function modifier_giant:RemoveOnDeath()
	return true
end

function modifier_giant:CanBeAddToMinions()
    return true
end

function modifier_giant:IsPurgable()
    return false
end

function modifier_giant:IsPurgeException()
    return false
end

function modifier_giant:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
    return funcs
end

function modifier_giant:GetModifierPreAttack_BonusDamage()	
	return self.damageBonus
end

function modifier_giant:GetModifierExtraHealthBonus()	
	return self.healthBonus
end

function modifier_giant:GetModifierModelScale()	
	return self.modelScalePerc
end

function modifier_giant:OnCreated()
	self.damageBonus = 100
	self.healthBonus = 1000
	self.modelScalePerc = 60

	if IsServer() then
		self:GetParent():SetRenderColor(255, 165, 0)
	end
end


