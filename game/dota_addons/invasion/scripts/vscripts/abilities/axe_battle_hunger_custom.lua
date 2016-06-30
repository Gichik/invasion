
axe_battle_hunger_custom = class({})

function axe_battle_hunger_custom:GetCastAnimation()
	EmitSoundOn("Hero_Axe.BerserkersCall.Start", self:GetCaster())	
    return ACT_DOTA_OVERRIDE_ABILITY_1 
end

 
 function axe_battle_hunger_custom:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET 
     return behav
 end

function axe_battle_hunger_custom:GetCastRange()	
    return self:GetSpecialValueFor("radius") 
end

function axe_battle_hunger_custom:OnUpgrade()
	local ability = self:GetCaster():FindAbilityByName("axe_battle_hunger")
	ability:UpgradeAbility(false)
	ability = self:GetCaster():FindAbilityByName("axe_berserkers_call")
	ability:UpgradeAbility(false)
end

function axe_battle_hunger_custom:OnSpellStart()

	local caster = self:GetCaster()

	local ability = self:GetCaster():FindAbilityByName("axe_berserkers_call")
	ability:CastAbility()

	ability = caster:FindAbilityByName("axe_battle_hunger") 
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, self:GetSpecialValueFor("radius") ,
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
		if units[ i ] then 
				caster:CastAbilityOnTarget(units[ i ], ability, caster:GetPlayerID())			
		end
	end
end

function axe_battle_hunger_custom:IsStealable()
	return false
end

function axe_battle_hunger_custom:IsHiddenWhenStolen()
	return true
end

