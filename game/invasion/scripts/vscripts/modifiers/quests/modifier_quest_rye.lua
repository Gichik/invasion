
modifier_quest_rye = class({})


function modifier_quest_rye:GetTexture()
    return "custom_folder/modifier_quest_rye"
end

function modifier_quest_rye:RemoveOnDeath()
	return true
end

function modifier_quest_rye:IsHidden()
	return false
end

function modifier_quest_rye:GiveMaxStack()
	return 10
end