
modifier_ghost_evasion = class({})


function modifier_ghost_evasion:GetTexture()
    return "custom_folder/ghost_evasion"
end

function modifier_ghost_evasion:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_EVASION_CONSTANT }
	return funcs
end


function modifier_ghost_evasion:GetModifierEvasion_Constant( params )
	return 100
end

function modifier_ghost_evasion:RemoveOnDeath()
	return true
end

function modifier_ghost_evasion:IsHidden()
	return false
end
