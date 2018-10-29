
if modifier_dismemberment == nil then
    modifier_dismemberment = class({})
end

function modifier_dismemberment:IsHidden()
	return true
end

function modifier_dismemberment:GetTexture()
    return "life_stealer_open_wounds"
end

function modifier_dismemberment:RemoveOnDeath()
	return true
end

function modifier_dismemberment:IsPurgable()
	return false
end

function modifier_dismemberment:IsPurgeException()
	return false
end

function modifier_dismemberment:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_dismemberment:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then

			local modifier = data.target:FindModifierByName("modifier_laceration")
			if modifier then
				modifier:IncrementStackCount()
				modifier:ForceRefresh()
			else
				data.target:AddNewModifier(data.attacker, self, "modifier_laceration", {duration = 15})
			end
			
		end
	end
end

