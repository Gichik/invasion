
modifier_iron_head = class({})


function modifier_iron_head:GetTexture()
    return "custom_folder/quests_icons/iron_head_icon"
end

function modifier_iron_head:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK }
	return funcs
end


function modifier_iron_head:GetModifierTotal_ConstantBlock()
	return 100
end

function modifier_iron_head:RemoveOnDeath()
	return true
end

function modifier_iron_head:IsHidden()
	return false
end
