function SplitShot(data)

	local caster = data.caster
	local target = data.target
	local ability = data.ability
	local arrow_count = ability:GetSpecialValueFor("arrow_count")

	local units = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false) 
	caster:RemoveModifierByName("modifier_split")
	
	if #units < arrow_count then 
		arrow_count = #units 
	end

	for i = 2, arrow_count do
		if units[ i ] then
			caster:PerformAttack(units[ i ], false, true, true, false, true)
		end
	end
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_split", {})
		
end