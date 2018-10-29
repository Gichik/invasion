
if modifier_elusive == nil then
    modifier_elusive = class({})
end

function modifier_elusive:IsHidden()
	return true
end

function modifier_elusive:GetTexture()
    return "riki_blink_strike"
end

function modifier_elusive:RemoveOnDeath()
	return true
end

function modifier_elusive:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
    }
    return funcs
end

function modifier_elusive:GetModifierEvasion_Constant()	
	return 100
end


