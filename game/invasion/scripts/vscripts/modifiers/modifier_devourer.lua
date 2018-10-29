
if modifier_devourer == nil then
    modifier_devourer = class({})
end

function modifier_devourer:IsHidden()
	return true
end

function modifier_devourer:GetTexture()
    return "life_stealer_feast"
end

function modifier_devourer:RemoveOnDeath()
	return true
end

function modifier_devourer:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_devourer:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			data.attacker:Heal(data.damage*0.7,data.attacker)
		end
	end
end