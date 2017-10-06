if modifier_stone_consumption == nil then
    modifier_stone_consumption = class({})
end

--function modifier_stone_consumption:GetAttributes()
--    return MODIFIER_ATTRIBUTE_MULTIPLE
--end

function modifier_stone_consumption:DeclareFunctions()
    return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end

function modifier_stone_consumption:GetTexture()
    return "td_ability/stone_consumption"
end


function modifier_stone_consumption:GetModifierConstantManaRegen()
		--if IsServer() then

        return -10*self:GetStackCount()
end


function modifier_stone_consumption:RemoveOnDeath()
    return true
end

function modifier_stone_consumption:IsBuff()
    return true
end

function modifier_stone_consumption:IsHidden()
    return false
end