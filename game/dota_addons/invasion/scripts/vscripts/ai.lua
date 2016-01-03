function BossCastSpell(data)
local ability = data.caster:FindAbilityByName("custom_exorcism")
local point = data.caster:GetOrigin()
data.caster:CastAbilityOnPosition(point, ability, -1 )
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
	if presentTime > 720 then
		way = Entities:FindByName( nil, "way_1") 
		unit:SetInitialGoalEntity( way )
	end
end
end

function CrawlOnNight(data)
local unit = data.caster

if GameRules:IsDaytime() == false then
	way = Entities:FindByName( nil, "way_2") 
	unit:SetInitialGoalEntity( way )
end
end