
modifier_critic = class({})


function modifier_critic:GetTexture()
    return "custom_folder/quests_icons/critic_icon"
end

function modifier_critic:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
	return funcs
end


function modifier_critic:GetModifierPreAttack_CriticalStrike()
	return 200
end

function modifier_critic:RemoveOnDeath()
	return true
end

function modifier_critic:IsHidden()
	return false
end
