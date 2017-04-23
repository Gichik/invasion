--LinkLuaModifier("modifier_extra_kick", "modifiers/modifier_extra_kick.lua", LUA_MODIFIER_MOTION_NONE )

function Rush(data)

	local caster = data.caster
	local target = data.target
	local ability = data.caster:FindAbilityByName("antimage_rush")
	local modifier = data.caster:FindModifierByName("modifier_prepare")
	local stackCount = 0

	if modifier then		
		stackCount = modifier:GetStackCount()
	end

	if stackCount == 0 then
		if RollPercentage(ability:GetSpecialValueFor("chance")) then
			ability:ApplyDataDrivenModifier( caster, caster, "modifier_rush", {duration = 2} )
			modifier:SetStackCount(ability:GetSpecialValueFor("attacks"))
			stackCount = modifier:GetStackCount()
			ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
		end
	else 
		modifier:DecrementStackCount()
		stackCount = modifier:GetStackCount()
	end

	if stackCount == 0 then
		caster:RemoveModifierByName("modifier_rush")
	end

end
