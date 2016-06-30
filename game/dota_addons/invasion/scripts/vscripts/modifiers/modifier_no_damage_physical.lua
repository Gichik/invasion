
modifier_no_damage_physical = class({})


function modifier_no_damage_physical:GetTexture()
    return "arc_warden_magnetic_field"
end

function modifier_no_damage_physical:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL }
	return funcs
end


function modifier_no_damage_physical:GetAbsoluteNoDamagePhysical( params )
	return 1
end

function modifier_no_damage_physical:RemoveOnDeath()
	return true
end

function modifier_no_damage_physical:IsHidden()
	return true
end
