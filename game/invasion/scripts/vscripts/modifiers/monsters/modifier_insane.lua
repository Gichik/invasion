
if modifier_insane == nil then
    modifier_insane = class({})
end

function modifier_insane:IsHidden()
	return false
end

function modifier_insane:GetTexture()
    return "warlock_fatal_bonds"
end

function modifier_insane:RemoveOnDeath()
	return true
end

function modifier_insane:CanBeAddToMinions()
    return true
end

function modifier_insane:IsPurgable()
    return false
end

function modifier_insane:IsPurgeException()
    return false
end

function modifier_insane:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_insane:GetModifierMoveSpeedBonus_Constant()	
	return self.moveSpeedBonus or 0
end

function modifier_insane:GetModifierAttackSpeedBonus_Constant()	
	return self.attackSpeedBonus or 0
end

function modifier_insane:OnCreated()
	self.moveSpeedBonus = 300
	self.attackSpeedBonus = 500

	if IsServer() then
		self:GetParent():SetRenderColor(255, 160, 122)
	end
end


