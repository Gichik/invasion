
modifier_cunning = class({})


function modifier_cunning:GetTexture()
    return "custom_folder/quests_icons/cunning_icon"
end

function modifier_cunning:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ATTACK_LANDED }
	return funcs
end


function modifier_cunning:OnAttackLanded(data)
	--for k,v in pairs(data) do
	--	print(k)
	--end
	print(data.target:GetUnitName())
	print(data.target:IsAlive())
end

function modifier_cunning:RemoveOnDeath()
	return true
end

function modifier_cunning:IsHidden()
	return false
end
