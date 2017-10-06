
modifier_quest_weapon = class({})


function modifier_quest_weapon:GetTexture()
    return "custom_folder/modifier_quest_weapon"
end

function modifier_quest_weapon:RemoveOnDeath()
	return true
end

function modifier_quest_weapon:IsHidden()
	return false
end

function modifier_quest_weapon:GiveMaxStack()
	return 5
end