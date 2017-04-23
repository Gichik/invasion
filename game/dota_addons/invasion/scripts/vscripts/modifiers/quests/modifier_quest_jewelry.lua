
modifier_quest_jewelry = class({})


function modifier_quest_jewelry:GetTexture()
    return "custom_folder/modifier_quest_jewelry"
end

function modifier_quest_jewelry:RemoveOnDeath()
	return true
end

function modifier_quest_jewelry:IsHidden()
	return false
end

function modifier_quest_jewelry:GiveMaxStack()
	return 10
end