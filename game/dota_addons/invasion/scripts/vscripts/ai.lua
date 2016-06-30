count_atatck = 0
can_run_glyph = 1



function BossCastSpell(data)
local ability = data.caster:FindAbilityByName("custom_exorcism")
local point = data.caster:GetOrigin()
data.caster:CastAbilityOnPosition(point, ability, -1 )
end


function MobCastTargetSpell(data)
	local caster = data.caster
	local ability = caster:FindAbilityByName(data.SpellName)

	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, ability:GetCastRange(),
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
		if units[ i ] and units[ i ]:GetName() ~= "npc_dota_creature" then 
				caster:CastAbilityOnTarget(units[ i ], ability, -1)			
		end
	end
end

function CastTomb(data)
	local ability = data.caster:FindAbilityByName("boss_tombstone")
	if ability:IsCooldownReady() then
		ability:CastAbility()
	end
end



function TombCreateUnits(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 700,
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[ i ] then 
			CreateUnitByName("tomb_half_zombies", heroes[ i ]:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )				
		end
	end

end

function KillUnit(data)
	local unit = data.target
	unit:ForceKill(false) 
end



function RunGlyph(data)
if data.caster:GetHealth() < 500 and can_run_glyph == 1 then
	data.caster:AddNewModifier(data.caster, nil, "modifier_windrunner_windrun", {duration = 15.0}) 
	can_run_glyph = 0
	Timers:CreateTimer(80,function()
		can_run_glyph = 1
		return nil
	end) 
end


end


function HommerCry(data)

if count_atatck > 49 then
	count_atatck = 0
end

if count_atatck == 0 then
	EmitGlobalSound("Invasion.HommerCry")
end

if count_atatck == 25 then
	EmitGlobalSound("Invasion.HommerDo")
end
count_atatck = count_atatck + 1
end


function Respawn(data)
local name = data.caster:GetUnitName()
local ability = data.caster:FindAbilityByName("respawn")
local IDspawn = ability:GetCastPoint()
local way = nil
local respTime = 20

if name == "cadaveric_bunch" then
	respTime = 30
elseif name == "pig" or name == "sheep" then 	
	respTime = 30
elseif name == "new_half_zombies" then 	
	respTime = 10	
end

Timers:CreateTimer(respTime,function()
	local point = Entities:FindByName( nil, "spawn_" .. IDspawn ):GetAbsOrigin()
	local unit = CreateUnitByName(name, point + RandomVector( RandomFloat( 0, 100 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(IDspawn)
	if IDspawn > 100 then
		way = Entities:FindByName( nil, "way_" .. IDspawn) 
		unit:SetInitialGoalEntity( way )
	end
return nil
end)
end

function RunOnNight(data)
local unit = data.caster
local presentTime = GameRules:GetDOTATime(false,false)

if GameRules:IsDaytime() == false then
	--if presentTime > 720 then
		way = Entities:FindByName( nil, "way_1") 
		unit:SetInitialGoalEntity( way )
	--end
end
end

function CrawlOnNight(data)
local unit = data.caster

if GameRules:IsDaytime() == false then
	way = Entities:FindByName( nil, "way_2") 
	unit:SetInitialGoalEntity( way )
end
end