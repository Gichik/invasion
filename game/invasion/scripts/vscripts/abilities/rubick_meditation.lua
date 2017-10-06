rubick_meditation = class({})
return_time = 1

function rubick_meditation:OnSpellStart()

	local caster = self:GetCaster()
	return_time = 1	
Timers:CreateTimer(1,function()
	local mana = caster:GetMana()
	local ability = caster:FindAbilityByName("rubick_meditation")
	local mana_cost = ability:GetSpecialValueFor("mana_cost_per_second")	
	if mana > mana_cost then
		local regen = ability:GetSpecialValueFor("regen")
		caster:SpendMana(mana_cost,ability)
		local id1 = ParticleManager:CreateParticle("particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_split_sparks_tormented.vpcf", PATTACH_ABSORIGIN_FOLLOW , caster)
		local id2 = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_telekinesis_impact_rings.vpcf", PATTACH_ABSORIGIN_FOLLOW , caster)
		local id3 = ParticleManager:CreateParticle("particles/econ/items/rubick/rubick_force_ambient/rubick_telekinesis_force_cube.vpcf", PATTACH_ABSORIGIN , caster)
		
		StartSoundEvent("DOTA_Item.FaerieSpark.Activate", caster)
		rubick_meditation:regen(self,regen)	
	end
		return return_time
	end)		
	
end

function rubick_meditation:OnChannelFinish(interrupted)		
		return_time = nil
end

function rubick_meditation:regen(self,regen)
	local caster = self:GetCaster()
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 600 ,DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for i = 1, #units do		
		if units[ i ] and units[ i ] ~= caster then 
			
			local id4 = ParticleManager:CreateParticle("particles/customgames/capturepoints/msg_capturepoints_allied.vpcf", PATTACH_ABSORIGIN_FOLLOW, units[ i ])
			local id5 = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, units[ i ])
			
			Timers:CreateTimer(0.5,function()
				ParticleManager:DestroyParticle(id4, false)
				return nil
			end)
			
			units[ i ]:Heal(regen,caster) 
			units[ i ]:GiveMana(regen)	
			
		end
	end
end


function rubick_meditation:IsHiddenWhenStolen()
	return true
end