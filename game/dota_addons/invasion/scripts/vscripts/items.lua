TABLE_PRESENT = {
	"item_radiance",
	"item_butterfly",
	"item_greater_crit",
	"item_satanic",
	"item_skadi" ,
	"item_mjollnir",
	"item_heart",
	"item_shivas_guard",
	"item_octarine_core"
}

function OctariniusModifiers(data)
print("OctariniusModifiers")

end

function GiveMana(data)
--print("give mana")
data.caster:GiveMana(100)
StartSoundEvent("Item.MoonShard.Consume", data.caster)
end

function GiveHealth(data)
--print("give heal")
local health = data.caster:GetHealth()+150
data.caster:SetHealth(health)
StartSoundEvent("DOTA_Item.Cheese.Activate", data.caster)
end

function RemoveItemFromHero(data)
local caster = data.caster
local item = nil
local charges = 0
local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name and first == 0 then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
					else
						caster:RemoveItem(item)
					end
				else
					caster:RemoveItem(item)			
				end
				first = 1
			end
		end
	end	
end

function CreateWoodWall(data)


	local caster = data.caster	
	local target = data.target	
	local point = target:GetAbsOrigin()

	target:SetHullRadius(50.0)
	target:SetForwardVector(caster:GetForwardVector())

	local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, 100,
			DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	for i = 1, #units do		
		if units[ i ] and units[ i ]:GetUnitName() ~= "wood_wall" then 
			FindClearSpaceForUnit(units[ i ],units[ i ]:GetAbsOrigin(),true)
		end
	end
end


function DestroyWoodWall(data)
--print("DestroyWoodWall")
--StartSoundEvent("Hero_Furion.Sprout", data.caster)
	data.caster:ForceKill(false)
end

function UpgradeWoodWall(data)
--print("DestroyWoodWall")
--StartSoundEvent("Hero_Furion.Sprout", data.caster)
	local caster = data.caster
	local hero = caster:GetOwner()
	local charges = 0

	if caster and caster:GetLevel() < 3 then

		if hero and hero:HasItemInInventory("item_wood_wall") then
			charges = GetChargesOfItem("item_wood_wall",hero)
		end

		if charges >= 5 then
			caster:CreatureLevelUp(1)
			caster:SetMaxHealth(caster:GetHealth()+1000)
			for i = 1, 5 do
				RemoveItemFromHero({caster = hero, item_name = "item_wood_wall"})
			end
		end 
	end
end

function RepairWoodWall(data)
--print("DestroyWoodWall")
	local caster = data.caster
	local hero = caster:GetOwner()
	local charges = 0
	local repairHealth = caster:GetHealth()/3

	if hero and hero:HasItemInInventory("item_wood_wall") then
		charges = GetChargesOfItem("item_wood_wall",hero)
	end

	if charges >= 1 then
		caster:Heal(repairHealth,hero)
		RemoveItemFromHero({caster = hero, item_name = "item_wood_wall"})
	end 
end

function GetChargesOfItem(itemName,hero)
	local item = nil
	local charges = 0
	local first = 0
		for i = 0, 5 do
			item = hero:GetItemInSlot(i)
			if item ~= nil then
				if item:GetAbilityName() == itemName and first == 0 then
					if item:IsStackable() == true then
						charges = item:GetCurrentCharges()			
					end
					first = 1
				end
			end
		end	
	return charges
end

function RemoveItemFromHero(data)
local caster = data.caster
local item = nil
local charges = 0
local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name and first == 0 then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
					else
						caster:RemoveItem(item)
					end
				else
					caster:RemoveItem(item)			
				end
				first = 1
			end
		end
	end	
end


function GivePresent(data)
	local caster = data.caster
	local item = nil
	local first = 0

	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == "item_custom_present" and first == 0 then
				caster:RemoveItem(item)
				first = 1
			end
		end
	end

	caster:AddItemByName(TABLE_PRESENT[RandomInt(1,#TABLE_PRESENT)])
end 

function TeslaLighting(data)
	local caster = data.caster
	local target = data.target
	local lightningBolt = nil
	local damage = nil
	local units = nil

	if RollPercentage(data.ability:GetSpecialValueFor("lighting_chance")) and not caster:IsRangedAttacker() then

		EmitSoundOn("Hero_Zuus.LightningBolt",target)
		
		units = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), target, data.ability:GetSpecialValueFor("lighting_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

		for i = 1, #units do		
			if units[ i ]  then 
				units[ i ]:AddNewModifier( caster, nil, "modifier_stunned", {duration = data.ability:GetSpecialValueFor("stun_duration")} )
				damage = {
							victim = units[ i ],
							attacker = caster,
							damage = math.floor(caster:GetAttackDamage()/2),
							damage_type = DAMAGE_TYPE_MAGICAL,
							ability = nil,
						}

				if units[ i ] ~= target then
					lightningBolt = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", PATTACH_WORLDORIGIN, units[ i ])
					ParticleManager:SetParticleControl(lightningBolt,0,target:GetAbsOrigin())   
					ParticleManager:SetParticleControl(lightningBolt,1,units[ i ]:GetAbsOrigin())				
					ApplyDamage( damage )
				end
			end
		end
	end
end


function CreateGoldChestOnMap(data)
	local caster = data.caster
	local item = nil
	local first = 0
	--print("CreateGoldChestOnMap")

	local point = Entities:FindByName( nil, "spawn_chest_point_" .. RandomInt(1,11) ):GetAbsOrigin()
	local unit = CreateUnitByName("npc_burial_gold_chest", point + RandomVector(200), true, nil, nil, DOTA_TEAM_NEUTRALS )
	unit:AddNewModifier( unit, nil, "modifier_invisible", {} )
	PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),unit)

	GameRules:GetGameModeEntity():SetContextThink(string.format("ChestThink_%d", unit:GetEntityIndex()), 
	function()
		PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(),caster)
		unit:RemoveModifierByName("modifier_burial_vision")
	return nil
	end,
	2)

	GameRules:GetGameModeEntity():SetContextThink(string.format("CameraThink_%d", caster:GetPlayerOwnerID()), 
	function()
		PlayerResource:SetCameraTarget(caster:GetPlayerOwnerID(), nil)	
	return nil
	end,
	3)
end 


function GiveGoldFromChest(data)
	local player = data.caster:GetOwner()
	local hero = PlayerResource:GetSelectedHeroEntity(player:GetPlayerID())
	local item = nil
	local first = 0

	ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, hero)
	PlayerResource:ModifyGold( player:GetPlayerID(), 500, true, 0 )
	SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, hero, 400, nil )
end 