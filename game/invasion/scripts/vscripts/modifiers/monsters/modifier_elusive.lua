
if modifier_elusive == nil then
    modifier_elusive = class({})
end

function modifier_elusive:IsHidden()
	return false
end

function modifier_elusive:GetTexture()
    return "riki_blink_strike"
end

function modifier_elusive:RemoveOnDeath()
	return true
end

function modifier_elusive:CanBeAddToMinions()
    return true
end

function modifier_elusive:IsPurgable()
	return false
end

function modifier_elusive:IsPurgeException()
	return false
end

function modifier_elusive:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT
    }
    return funcs
end

function modifier_elusive:GetModifierEvasion_Constant()	
	return self.evasionBonus or 0
end

function modifier_elusive:OnCreated()
	self.evasionBonus = 80

	if IsServer() then
		self:GetParent():SetRenderColor(72, 61, 139)
	end
end


