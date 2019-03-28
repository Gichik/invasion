
if modifier_devourer_classic_classic == nil then
    modifier_devourer_classic = class({})
end

function modifier_devourer_classic:IsHidden()
	return true
end

function modifier_devourer_classic:GetTexture()
    return "life_stealer_feast"
end

function modifier_devourer_classic:RemoveOnDeath()
	return true
end

function modifier_devourer_classic:IsPurgable()
	return false
end

function modifier_devourer_classic:IsPurgeException()
	return false
end

function modifier_devourer_classic:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_devourer_classic:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			data.attacker:Heal(data.damage*0.7,data.attacker)
		end
	end
end