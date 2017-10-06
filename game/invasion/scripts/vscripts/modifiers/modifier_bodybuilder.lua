
modifier_bodybuilder = class({})


function modifier_bodybuilder:GetTexture()
    return "custom_folder/quests_icons/bodybuilder_icon"
end

function modifier_bodybuilder:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS }
	return funcs
end


function modifier_bodybuilder:GetModifierBonusStats_Strength()
	return 30
end

function modifier_bodybuilder:RemoveOnDeath()
	return true
end

function modifier_bodybuilder:IsHidden()
	return false
end
