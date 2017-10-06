
if item_basis_of_turret == nil then
    item_basis_of_turret = class({})
end

--[[function item_basis_of_turret:GetAbilityTextureName()
	if self:IsItem() then
  		return "td_items/basis_of_turret"
  	else
  		return "td_ability/ability_repair" 
  	end]
  	self.BaseClass.GetAbilityTextureName(self)
end]

--[[
function item_basis_of_turret:GetTexture()
	print("ok 2")
	return "ability_repair"
end]]

function item_basis_of_turret:GetChannelAnimation()
    return ACT_DOTA_ATTACK2
end

function item_basis_of_turret:GetCastAnimation()
    return ACT_DOTA_ATTACK2
end


function item_basis_of_turret:CastFilterResultLocation(vLocation)
	--print("Error")
	if IsServer() then
		if vLocation.z < 250 then
			return UF_FAIL_CUSTOM 
		end

		local caster = self:GetCaster()
		local long_away = true
		local units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 100,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
			
		if #units >0 then
			return UF_FAIL_CUSTOM
		end

		units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 1000,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

		for i = 1, #units do
			if units[ i ] then 
				if units[ i ]:GetUnitName() == "npc_generator"  then
					long_away = false
				end
			end
		end

		if long_away then
			return UF_FAIL_CUSTOM
		end

		return UF_SUCCESS
	end
end


function item_basis_of_turret:OnSpellStart()		
	--print("OnSpellStart")
	self:GetCaster():EmitSound("Hero_Tinker.Rearm")
end

			
function item_basis_of_turret:OnChannelFinish(interrupted)		
		--print("interrupted: ")
		--print(interrupted)
		if not interrupted then
			local point = self:GetCursorPosition()
			CreateUnitByName("npc_tower_turret", point, false, nil, nil, DOTA_TEAM_GOODGUYS )
			--RemoveStoneFromHero(self)			
		end
end

function item_basis_of_turret:GetCustomCastErrorLocation( vLocation )
	if IsServer() then
		if vLocation.z < 250 then
			return "#dota_hud_error_cant_build_on_low_ground" 
		end

		local caster = self:GetCaster()
		local long_away = true
		local units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 100,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
			
		if #units >0 then
			return "#dota_hud_error_cant_build_another_unit"
		end

		units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 1000,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )


		for i = 1, #units do
			if units[ i ] then 
				if units[ i ]:GetUnitName() == "npc_generator"  then
					long_away = false
				end
			end
		end

		if long_away then
			return "#dota_hud_error_cant_build_long_away"
		end

		return "Error"
	end
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