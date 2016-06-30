power_of_faith = class({})

function power_of_faith:OnToggle()


Timers:CreateTimer(1,function()
	local mana = self:GetCaster():GetMana()
	local mana_cost = self:GetCaster():FindAbilityByName("power_of_faith"):GetSpecialValueFor("mana_cost_per_second")	
	if mana > mana_cost then
		local dmg = self:GetCaster():FindAbilityByName("power_of_faith"):GetSpecialValueFor("damage")
		self:GetCaster():SpendMana(mana_cost,self:GetCaster():FindAbilityByName("power_of_faith"))
		local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_land_mine_ball_explosion.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		--Timers:CreateTimer(1,function()
		--	ParticleManager:DestroyParticle(id1, false)
		--	return nil
		--end)
		power_of_faith:damage(self,dmg)	
	end
	if self:GetToggleState() then
		return 1
	else
		return nil
	end
	end)		
	
end


function power_of_faith:damage(self,dmg)
	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), self:GetCaster(), 500 ,DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for i = 1, #units do		
	if units[ i ] then 
		if units[ i ]:GetUnitName() ~= "pig" and units[ i ]:GetUnitName() ~= "sheep" then
			--StartSoundEvent("Hero_Spirit_Breaker.GreaterBash", units[ i ])

			local id2 = ParticleManager:CreateParticle("particles/dire_fx/tower_bad_face_end_ball.vpcf", PATTACH_OVERHEAD_FOLLOW , units[ i ])
			
			Timers:CreateTimer(1,function()
				ParticleManager:DestroyParticle(id2, false)
				return nil
			end)
		

			local damage = {
				victim = units[ i ],
				attacker = self:GetCaster(),
				damage = dmg,
				damage_type = DAMAGE_TYPE_PURE,
				ability = this
			}
			ApplyDamage( damage )	
		end
	end
	end
end


function power_of_faith:IsHiddenWhenStolen()
	return true
end