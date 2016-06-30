
modifier_autocast_culling_blade = class({})

function modifier_autocast_culling_blade:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_START, MODIFIER_EVENT_ON_ATTACK }
end

function modifier_autocast_culling_blade:GetTexture()
    return "axe_culling_blade"
end

function modifier_autocast_culling_blade:OnAttack( data )
	
	local caster = self:GetParent()
	local target = data.target
	
	if data.attacker == caster then
		local ability = caster:FindAbilityByName("axe_culling_blade_custom")

		if target ~= nil and target:GetTeamNumber() ~= caster:GetTeamNumber() then
			if ability:IsFullyCastable() then 
				caster:CastAbilityOnTarget(target, ability, caster:GetPlayerID())
			end
		end	
	end

end

function modifier_autocast_culling_blade:RemoveOnDeath()
	return true
end

function modifier_autocast_culling_blade:IsHidden()
	return true
end
