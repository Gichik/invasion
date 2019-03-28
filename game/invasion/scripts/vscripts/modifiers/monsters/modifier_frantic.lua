
if modifier_frantic == nil then
    modifier_frantic = class({})
end

function modifier_frantic:IsHidden()
	return false
end

function modifier_frantic:GetTexture()
    return "nevermore_dark_lord"
end

function modifier_frantic:RemoveOnDeath()
	return true
end

function modifier_frantic:CanBeAddToMinions()
    return true
end

function modifier_frantic:IsPurgable()
    return false
end

function modifier_frantic:IsPurgeException()
    return false
end

function modifier_frantic:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
    }
    return funcs
end

function modifier_frantic:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()*self.attackSpeedBonus or 0
end

function modifier_frantic:GetModifierMagicalResistanceBonus()	
	return self:GetStackCount()*self.magicResistBonus or 0
end

function modifier_frantic:GetModifierIncomingPhysicalDamage_Percentage()		
	return self:GetStackCount()*self.physArmorBonus or 0
end

function modifier_frantic:OnCreated()
	self.attackSpeedBonus = 20
	self.magicResistBonus = 9
	self.physArmorBonus = -9
	self.thresholdPerc = 10 

	if IsServer() then
		self:GetParent():SetRenderColor(75, 0, 130)
		self:StartIntervalThink(0.3) 
	end
end

function modifier_frantic:OnIntervalThink()
	local stack = self:GetParent():GetMaxHealth()*self.thresholdPerc/100
	stack = (self:GetParent():GetMaxHealth() - self:GetParent():GetHealth())/stack
	self:SetStackCount(stack)
end


