
if item_purple_stone_of_poison == nil then
    item_purple_stone_of_poison = class({})
end

LinkLuaModifier("modifier_stone_consumption", "modifiers/td_modifiers/modifier_stone_consumption.lua", LUA_MODIFIER_MOTION_NONE )
item = item_purple_stone_of_poison


function GetSkillName()
    return "skill_broodmother_incapacitating_bite"
end

function item:GetChannelAnimation()
    return ACT_DOTA_ATTACK2
end

function item:GetCastAnimation()
    return ACT_DOTA_ATTACK2
end


function item:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:GetUnitName() ~= "npc_tower_turret" then
			return UF_FAIL_CUSTOM
		end

		if hTarget:HasAbility(GetSkillName()) then
			if hTarget:FindAbilityByName(GetSkillName()):GetLevel()>=3 then
				return UF_FAIL_CUSTOM
			else
				return UF_SUCCESS
			end
		end	

		local emptyAbilitySlot = false
		local abilityName = "tower_empty_slot_"

		for i = 1, 3 do
			if hTarget:HasAbility(abilityName .. i) then
				emptyAbilitySlot = true
				break
			end
		end

		if not emptyAbilitySlot then
			return UF_FAIL_CUSTOM
		end

		return UF_SUCCESS
	end
end


function item:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then
		if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
			return "#dota_hud_error_cant_use_on_target"
		end

		if hTarget:GetUnitName() ~= "npc_tower_turret" then
			return "#dota_hud_error_cant_use_on_target"
		end

		if hTarget:HasAbility(GetSkillName()) then
			if hTarget:FindAbilityByName(GetSkillName()):GetLevel()>=3 then
				return "#dota_hud_error_cant_upgrade_max_level"
			else
				return UF_SUCCESS
			end
		end	

		local emptyAbilitySlot = false
		local abilityName = "tower_empty_slot_"

		for i = 1, 3 do
			if hTarget:HasAbility(abilityName .. i) then
				emptyAbilitySlot = true
				break
			end
		end

		if not emptyAbilitySlot then
			return "#dota_hud_error_full_slots"
		end

		return UF_SUCCESS
	end
end

function item:OnSpellStart()		
	--print("OnSpellStart")
	local target = self:GetCursorTarget()
	local abilityName = "tower_empty_slot_"
	local ability = nil

	target:EmitSound("DOTA_Item.MedallionOfCourage.Activate")
	if target:HasAbility(GetSkillName()) then
		ability = target:FindAbilityByName(GetSkillName())
	else
		for i = 1, 3 do
			if target:HasAbility(abilityName .. i) then
				target:RemoveAbility(abilityName .. i)
				ability = target:AddAbility(GetSkillName())
				break
			end
		end
	end

	ability:UpgradeAbility(false)

	if target:HasModifier("modifier_stone_consumption") then
		target:FindModifierByName("modifier_stone_consumption"):IncrementStackCount()
	else
		target:AddNewModifier(target, nil, "modifier_stone_consumption", {}):IncrementStackCount()
	end

	RemoveStoneFromHero(self)
end

function RemoveStoneFromHero(ability)
	local caster = ability:GetCaster()
	local item = nil
	local charges = 0
	local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == ability:GetName() then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
						return nil
					else
						caster:RemoveItem(item)
						return nil
					end
				else
					caster:RemoveItem(item)	
					return nil		
				end
			end
		end
	end	
end
