
boss_tombstone = class({})

function boss_tombstone:GetCastAnimation()
	--EmitSoundOn("Hero_Axe.BerserkersCall.Start", self:GetCaster())	
    return ACT_DOTA_OVERRIDE_ABILITY_1 
end

 
 function boss_tombstone:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET 
     return behav
 end

function boss_tombstone:OnSpellStart()

	local caster = self:GetCaster()
	local ability = self:GetCaster():FindAbilityByName("custom_boss_tombstone")
	local point_1 = caster:GetAbsOrigin()+Vector(500,0,0)
	local point_2 = caster:GetAbsOrigin()+Vector(0,500,0)
	local point_3 = caster:GetAbsOrigin()+Vector(-250,-250,0)

	local unit = CreateUnitByName("boss_cadaveric_bunch", point_1, true, nil, nil, DOTA_TEAM_BADGUYS )		 
	unit = CreateUnitByName("boss_cadaveric_bunch", point_2, true, nil, nil, DOTA_TEAM_BADGUYS )
	unit = CreateUnitByName("boss_cadaveric_bunch", point_3, true, nil, nil, DOTA_TEAM_BADGUYS )
--	caster:CastAbilityOnPosition(point_1, ability, -1)			
--	caster:CastAbilityOnPosition(point_2, ability, -1)
--	caster:CastAbilityOnPosition(point_3, ability, -1)

end

function boss_tombstone:IsStealable()
	return false
end

function boss_tombstone:IsHiddenWhenStolen()
	return true
end

