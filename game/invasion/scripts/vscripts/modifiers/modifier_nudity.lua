
modifier_nudity = class({})


function modifier_nudity:GetTexture()
    return "custom_folder/quests_icons/nudity_icon"
end

function modifier_nudity:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_STATS_INTELLECT_BONUS }
	return funcs
end


function modifier_nudity:GetModifierBonusStats_Intellect()
	return 30
end

function modifier_nudity:RemoveOnDeath()
	return true
end

function modifier_nudity:IsHidden()
	return false
end
