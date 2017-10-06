

LinkLuaModifier("modifier_movespeed_slow", "modifiers/modifier_movespeed_slow.lua", LUA_MODIFIER_MOTION_NONE )


count_atatck = 0
can_run_glyph = 1


function SetColorForUnit(data)
	local unit = data.caster
	unit:SetRenderColor(tonumber(data.a),tonumber(data.b),tonumber(data.c))
end

function BossCastSpell(data)
	local ability = data.caster:FindAbilityByName("custom_exorcism")
	ability:CastAbility()
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


function HealZombie(data)
	local caster = data.caster

	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 800,
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
		if units[ i ] then 
			units[i]:Heal(5,caster)				
		end
	end
end


function ZombieIceHit(data)
	local unit = data.target
	unit:AddNewModifier( data.caster, self, "modifier_movespeed_slow", {duration = 3} )
end

function PudgeCastAcidSpray(data)
	local ability = data.caster:FindAbilityByName("zombie_acid_spray")
	local point = data.caster:GetOrigin()
	data.caster:CastAbilityOnPosition(point, ability, -1 )
	data.caster:ForceKill(false)
	StartSoundEvent("Hero_LifeStealer.Assimilate.Destroy", data.caster)
end


function CreateHalfUnit(data)
	local unit = CreateUnitByName("forest_poison_half_zombies", data.caster:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS )
	unit:SetRenderColor(0, 255, 128)				
end


function KillUnit(data)
	local unit = data.target
	unit:ForceKill(false) 
end

function RunGlyph(data)
if data.caster:GetHealth() < 500 and can_run_glyph == 1 then
	data.caster:AddNewModifier(data.caster, nil, "modifier_invulnerable", {duration = 15.0}) 
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



function SetSpawnSettings(data)
	local unit = data.caster
	if not unit.vSpawnLoc then
		unit.vSpawnLoc = unit:GetAbsOrigin()
	end
	if not unit.vSpawnVector then
		unit.vSpawnVector = unit:GetForwardVector()
	end		
end


function Respawn(data)

--[[
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
--]]

	local moob = data.caster
	local name = moob:GetUnitName()
	local SpawnLoc = moob.vSpawnLoc
	local SpawnVector = moob.vSpawnVector
	local a = 255
	local b = 255
	local c = 255
	local clearSpace = true
	local team = moob:GetTeamNumber()
--[[
	if data.Team == "DOTA_TEAM_GOODGUYS" then
		team = DOTA_TEAM_GOODGUYS
	end
	if data.Team == "DOTA_TEAM_BADGUYS" then
		team = DOTA_TEAM_BADGUYS
	end
	if data.Team == "DOTA_TEAM_NEUTRALS" then
		team = DOTA_TEAM_NEUTRALS
	end	]]	

	if data.FindClearSpace == "0" then
		clearSpace = false
	end


	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	if (SpawnVector == nil) then
		SpawnVector = Vector(0,-1,0)
	end

	if name == "forest_ice_zombie" then
		a = 0
		b = 204
		c = 204
	end

	if name == "forest_poison_zombie" then
		a = 0
		b = 255
		c = 128
	end

	if name == "toothy_zombies" then
		a = 175
		b = 0
		c = 0
	end	

	if name == "npc_candy" then
		team = DOTA_TEAM_GOODGUYS
	end

	GameRules:GetGameModeEntity():SetContextThink(string.format("RespawnThink_%d",moob:GetEntityIndex()), 
		function()
		local unit = CreateUnitByName(name, SpawnLoc, clearSpace, nil, nil, team )
		unit.vSpawnLoc = SpawnLoc 
		unit.vSpawnVector = SpawnVector
		unit:SetForwardVector(SpawnVector)
		unit:SetRenderColor(a, b, c)
		end,
		data.Time)		

end


function RespawnNeutralByGaindLevel(data)

	local moob = data.caster
	local name = moob:GetUnitName()
	local level = moob:GetLevel()		
	local SpawnLoc = moob.vSpawnLoc
	local SpawnVector = moob.vSpawnVector
	local team = DOTA_TEAM_NEUTRALS

	local a = 255
	local b = 255
	local c = 255
	local clearSpace = true


	if data.FindClearSpace == "0" then
		clearSpace = false
	end


	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	if (SpawnVector == nil) then
		SpawnVector = Vector(0,-1,0)
	end

	GameRules:GetGameModeEntity():SetContextThink(string.format("RespawnThink_%d",moob:GetEntityIndex()), 
		function()
		local unit = CreateUnitByName(name, SpawnLoc, clearSpace, nil, nil, team )
		unit:CreatureLevelUp(level)
		unit.vSpawnLoc = SpawnLoc 
		unit.vSpawnVector = SpawnVector
		unit:SetForwardVector(SpawnVector)
		unit:SetRenderColor(a, b, c)
		end,
		data.Time)		
end


function RespawnBurialOfJewelry(data)

	local moob = data.caster
	local name = "npc_burial_of_jewelry"
	local SpawnLoc = Entities:FindByName( nil, "spawn_jewelry_point_" .. RandomInt(1,12) ):GetAbsOrigin()
	local team = DOTA_TEAM_NEUTRALS

	local clearSpace = true

	if data.FindClearSpace == "0" then
		clearSpace = false
	end


	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	GameRules:GetGameModeEntity():SetContextThink(string.format("RespawnThink_%d",moob:GetEntityIndex()), 
		function()
		local unit = CreateUnitByName(name, SpawnLoc, clearSpace, nil, nil, team )
		end,
		data.Time)		
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

--[[
function SetMoveToPosition(data)

	local callerName = data.caller:GetName()
	local unit = data.activator
	local position = Vector(1,1,1)

	if callerName == "patrule_trigger_1" then
		position = Entities:FindByName( nil, "patrule_trigger_2"):GetAbsOrigin()
	end
	if callerName == "patrule_trigger_2" then
		position = Entities:FindByName( nil, "patrule_trigger_1"):GetAbsOrigin()
	end

	unit:MoveToPositionAggressive(position)

end]]

function ForceAttackCaster(data)
	local caster = data.caster
	local target = data.target

	target:SetForceAttackTarget(nil)

	if caster:IsAlive() then
		local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster:entindex()
		}

		ExecuteOrderFromTable(order)
		target:SetForceAttackTarget(caster)
--[[
		local damage = {
			victim = caster,
			attacker = target,
			damage = 1,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = nil,
		}
		ApplyDamage( damage )]]		
	else
		target:Stop()
		target:SetForceAttackTarget(nil)
	end

end

function AddCandy(data)
	data.caster:AddNoDraw()
	local unit = data.attacker
	local ability = data.caster:FindAbilityByName("candy_bag")
	if unit and unit:HasModifier("modifier_candy") then
		unit:FindModifierByName("modifier_candy"):IncrementStackCount()
	else
		if ability then
			ability:ApplyDataDrivenModifier( data.caster, data.attacker, "modifier_candy", {} )
			unit:FindModifierByName("modifier_candy"):IncrementStackCount()
		end
	end
end

function WindowTeleport(data)
	local caster = data.activator
	local point = caster:GetAbsOrigin()
	local callerName = data.caller:GetName()

	if callerName == "window_trigger_1" then
		caster:SetAbsOrigin(Vector(896,256,520))
	end
	if callerName == "window_trigger_2" then
		caster:SetAbsOrigin(Vector(1536,256,128))
	end	

	caster:Stop()
end

function IncreaseCandyCount(data)
	local hero = data.activator

	if hero and hero:HasModifier("modifier_candy") then
		CandyCount = CandyCount + hero:FindModifierByName("modifier_candy"):GetStackCount()
		hero:RemoveModifierByName("modifier_candy")

		ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, hero)
		SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, hero, 0, nil )
		EmitSoundOn("DOTA_Item.Cheese.Activate",hero)

		GameRules:SendCustomMessage("<font color='#58ACFA'>New cande has been steal! Candy count now: </font>" .. CandyCount, 0, 0)
	end

	if CandyCount >= 80 then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end
end

function TrapCheck(data)

	local caster = data.caster
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 150,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then 
		--if units[ 1 ] then
			local damage = {
				victim = units[ 1 ],
				attacker = data.caster,
				damage = 500,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = data.caster:FindAbilityByName("trap_check"),
			}
			ApplyDamage( damage )
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			EmitSoundOn("DOTA_Item.Maim", data.caster)
			data.caster:ForceKill(false)
		--end
	end
	
end

function HungerOnNight(data)
	local unit = data.caster
	local presentTime = GameRules:GetDOTATime(false,false)
	local abs = unit:GetAbsOrigin()
	local way = nil

	if GameRules:IsDaytime() == false then
		unit:SetAcquisitionRange(10000.0)
		if abs.y > -264 then
			way = Entities:FindByName( nil, "way_dire") 
			unit:SetInitialGoalEntity( way )		
		else
			way = Entities:FindByName( nil, "way_radiant") 
			unit:SetInitialGoalEntity( way )
		end		
	else
		unit:SetAcquisitionRange(10.0)
	end
end

function ApplySleepParticle(data)
	local unit = data.caster

	Timers:CreateTimer(1,function()
		unit.pID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_sleep.vpcf", PATTACH_OVERHEAD_FOLLOW, unit)
	return nil
	end) 


end

function RemoveSleepParticle(data)
	local unit = data.caster

	if unit.pID then
		ParticleManager:DestroyParticle(unit.pID, false)
		unit.pID = nil
	end
end