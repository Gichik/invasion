freezing_field = class({})

function freezing_field:OnSpellStart()

for i = 1, 9 do
Timers:CreateTimer(i,function()
	freezing_field:freeze(self)
end)
end

local hero = self:GetCaster()
if hero:FindAbilityByName("crystal_maiden_freezing_field_custom") == nil then
	hero:AddAbility("crystal_maiden_freezing_field_custom")
	local ability = hero:FindAbilityByName("crystal_maiden_freezing_field_custom")
	ability:SetLevel(self:GetLevel())
	ability:CastAbility()		
end	

Timers:CreateTimer(9,function()
	hero:RemoveAbility("crystal_maiden_freezing_field_custom")
end)



	
end


function freezing_field:freeze(self)
	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), self:GetCaster(), 1000 ,DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )	
	
	local knockbackModifierTable =
	{
	spellName = "crystal_maiden_frostbite", 
	damage_per_second_tooltip = 50, 
	duration = 10,
	hero_damage_tooltip = 50,
	creep_duration = 10,
	creep_damage_tooltip = 50,
	damage = 50
	}	
	
	for i = 1, #units do		
		if units[ i ] then 
				units[ i ]:AddNewModifier( self:GetCaster(), nil, "modifier_crystal_maiden_frostbite", knockbackModifierTable )				
		end
	end
end


function freezing_field:IsHiddenWhenStolen()
	return true
end