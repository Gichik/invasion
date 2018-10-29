
if modifier_laceration == nil then
    modifier_laceration = class({})
end

function modifier_laceration:IsHidden()
	return false
end

function modifier_laceration:IsDebuff()
	return true
end

function modifier_laceration:GetTexture()
    return "life_stealer_open_wounds"
end

function modifier_laceration:RemoveOnDeath()
	return true
end

function modifier_laceration:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
    return funcs
end

function modifier_laceration:GetModifierIncomingDamage_Percentage()	
	return self:GetStackCount() * 30
end

