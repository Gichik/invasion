
modifier_love = class({})


function modifier_love:GetTexture()
    return "custom_folder/quests_icons/love_icon"
end

function modifier_love:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
	return funcs
end


function modifier_love:GetModifierConstantManaRegen()
	return 30
end

function modifier_love:GetModifierConstantHealthRegen()
	return 30
end

function modifier_love:RemoveOnDeath()
	return true
end

function modifier_love:IsHidden()
	return false
end
