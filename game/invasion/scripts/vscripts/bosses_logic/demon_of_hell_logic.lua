function BossCastSpell(data)

	local caster = data.caster
	local ability = caster:FindAbilityByName(data.SpellName)


	if ability then
		if ability:GetAbilityName() == "demon_fiends_grip" then
			local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 1000,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

			for i = 1, #heroes do		
				if heroes[i] then
					caster:CastAbilityOnTarget(heroes[i], ability, -1 )		
				end
			end
		end
		if ability:GetAbilityName() == "demon_reflection" then
			ability:CastAbility()
		end
	end
	--local ability = data.caster:FindAbilityByName("dead_witch_exorcism")
	--local point = data.caster:GetAbsOrigin()
	--data.caster:CastAbilityOnPosition(point, ability, -1 )
end


function SoulEaterHeal(data)
	local caster = data.caster
	caster:Heal(data.HealthRegen,caster)
	caster:GiveMana(data.ManaRegen)
end


function ExplosionCorpse(data)
	local caster = data.unit
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 200,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	for i = 1, #units do
		if units[i] and units[i]:GetUnitName() ~= "NPC_base" then
	        ApplyDamage( { victim = units[i], attacker = data.caster, damage = data.ExplDamage,
                damage_type = DAMAGE_TYPE_PURE, ability = data.ability} )		
		end
	end	
end
