
modifier_rabid_giggles = class({})


function modifier_rabid_giggles:GetTexture()
    return "custom_folder/quests_icons/rabid_giggles_icon"
end

function modifier_rabid_giggles:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	return funcs
end


function modifier_rabid_giggles:GetModifierAttackSpeedBonus_Constant()
	return 100
end

function modifier_rabid_giggles:RemoveOnDeath()
	return true
end

function modifier_rabid_giggles:IsHidden()
	return false
end
