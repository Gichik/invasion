
modifier_fat_ass = class({})


function modifier_fat_ass:GetTexture()
    return "custom_folder/quests_icons/fat_ass_icon"
end

function modifier_fat_ass:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
	return funcs
end


function modifier_fat_ass:GetModifierPhysicalArmorBonus()
	return 30
end

function modifier_fat_ass:GetModifierMagicalResistanceBonus()
	return 30
end

function modifier_fat_ass:RemoveOnDeath()
	return true
end

function modifier_fat_ass:IsHidden()
	return false
end
