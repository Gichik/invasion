
modifier_strange_man = class({})


function modifier_strange_man:GetTexture()
    return "custom_folder/quests_icons/strange_man_icon"
end

function modifier_strange_man:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_STATS_AGILITY_BONUS }
	return funcs
end


function modifier_strange_man:GetModifierBonusStats_Agility()
	return 30
end

function modifier_strange_man:RemoveOnDeath()
	return true
end

function modifier_strange_man:IsHidden()
	return false
end
