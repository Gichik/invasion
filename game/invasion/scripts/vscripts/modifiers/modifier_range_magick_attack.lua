
if modifier_range_magick_attack == nil then
    modifier_range_magick_attack = class({})
end

function modifier_range_magick_attack:IsHidden()
	return true
end

function modifier_range_magick_attack:GetTexture()
    return "shadow_demon_disruption"
end

function modifier_range_magick_attack:RemoveOnDeath()
	return true
end

function modifier_range_magick_attack:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_range_magick_attack:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			local hAbility = self:GetAbility()
			ApplyDamage({
	            victim = data.target,
	            attacker = data.attacker,
	            damage = RandomInt(hAbility:GetSpecialValueFor("damage_min"), hAbility:GetSpecialValueFor("damage_max")),
	            damage_type = DAMAGE_TYPE_MAGICAL,
	            ability = hAbility
	           })
		end
	end
end