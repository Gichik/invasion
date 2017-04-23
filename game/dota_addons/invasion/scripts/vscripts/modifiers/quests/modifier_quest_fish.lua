
modifier_quest_fish = class({})


function modifier_quest_fish:GetTexture()
    return "custom_folder/modifier_quest_fish"
end

function modifier_quest_fish:RemoveOnDeath()
	return true
end

function modifier_quest_fish:IsHidden()
	return false
end

function modifier_quest_fish:GiveMaxStack()
	return 10
end