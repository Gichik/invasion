
if modifier_elusive_classic == nil then
    modifier_elusive_classic = class({})
end

function modifier_elusive_classic:IsHidden()
	return true
end

function modifier_elusive_classic:GetTexture()
    return "riki_blink_strike"
end

function modifier_elusive_classic:RemoveOnDeath()
	return true
end

function modifier_elusive_classic:IsPurgable()
	return false
end

function modifier_elusive_classic:IsPurgeException()
	return false
end


function modifier_elusive_classic:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
    }
    return funcs
end

function modifier_elusive_classic:GetModifierEvasion_Constant()	
	return 100
end


