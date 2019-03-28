
if modifier_devourer == nil then
    modifier_devourer = class({})
end

function modifier_devourer:IsHidden()
	return false
end

function modifier_devourer:GetTexture()
    return "life_stealer_feast"
end

function modifier_devourer:RemoveOnDeath()
	return true
end

function modifier_devourer:CanBeAddToMinions()
    return true
end

function modifier_devourer:IsPurgable()
	return false
end

function modifier_devourer:IsPurgeException()
	return false
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
			data.attacker:Heal(data.damage,data.attacker)
		end
	end
end

function modifier_devourer:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(139, 0, 0) 
	end
end