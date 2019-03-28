
if modifier_breaking_bone == nil then
    modifier_breaking_bone = class({})
end

function modifier_breaking_bone:IsHidden()
	return false
end

function modifier_breaking_bone:GetTexture()
    return "spirit_breaker_greater_bash"
end

function modifier_breaking_bone:RemoveOnDeath()
	return true
end

function modifier_breaking_bone:CanBeAddToMinions()
    return true
end

function modifier_breaking_bone:IsPurgable()
	return false
end

function modifier_breaking_bone:IsPurgeException()
	return false
end

function modifier_breaking_bone:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_breaking_bone:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			data.target:AddNewModifier(data.attacker, self, "modifier_stunned", {duration = 0.2})
		end
	end
end

function modifier_breaking_bone:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(105, 105, 105) 
	end
end