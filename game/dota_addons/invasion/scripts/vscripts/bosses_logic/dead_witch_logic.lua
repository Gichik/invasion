

--LinkLuaModifier("modifier_movespeed_slow", "modifiers/modifier_movespeed_slow.lua", LUA_MODIFIER_MOTION_NONE )


function BossCastSpell(data)
	local ability = data.caster:FindAbilityByName("dead_witch_exorcism")
	local point = data.caster:GetAbsOrigin()
	data.caster:CastAbilityOnPosition(point, ability, -1 )
end

function CastSecondPhase(data)

	local caster = data.caster
	local threshold = caster:GetBaseMaxHealth()/2
	local ability = data.caster:FindAbilityByName("dead_witch_overgrowth")

	if caster:GetHealth() < threshold and ability:IsFullyCastable() then
		ability:CastAbility()

		ability = caster:FindAbilityByName("dead_witch_maledict")

		local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, ability:GetCastRange(),
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
		for i = 1, #heroes do		
			if heroes[i] then
				local point = heroes[i]:GetOrigin()
				caster:CastAbilityOnPosition(point, ability, -1 )		
			end
		end

	end
end
