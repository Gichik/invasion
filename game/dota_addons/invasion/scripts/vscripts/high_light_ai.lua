function GiveTeleport(data)	
	local hero = data.activator
	if (hero:FindAbilityByName("wisp_teleport") == nil) and (hero:GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
		hero:AddAbility("wisp_teleport")
		local ability = hero:FindAbilityByName("wisp_teleport")
		ability:SetLevel(1)
	end
end

function RemoveTeleport(data)
	local hero = data.activator
	local ability = hero:FindAbilityByName("wisp_teleport")
	if ability ~= nil then
		hero:RemoveAbility("wisp_teleport")
	end
end


function Teleport(data)
	local caster = data.caster
	local point = caster:GetAbsOrigin()
	local ent = Entities:FindInSphere(caster,point,100)

	if ent:GetName() == "trigger_teleport_1_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_1_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_1_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_1_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_2_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_2_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_2_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_2_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_3_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_3_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_3_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_3_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_4_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_4_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_4_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_4_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_5_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_5_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_5_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_5_1"):GetAbsOrigin())
	end	

	if ent:GetName() == "trigger_teleport_6_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_6_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_6_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_6_1"):GetAbsOrigin())
	end	

	if ent:GetName() == "trigger_teleport_7_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_7_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_7_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_7_1"):GetAbsOrigin())
	end	

	if ent:GetName() == "trigger_teleport_8_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_8_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_8_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_8_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_9_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_9_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_9_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_9_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_10_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_10_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_10_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_10_1"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_11_1" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_11_2"):GetAbsOrigin())
	end

	if ent:GetName() == "trigger_teleport_11_2" then
		caster:SetAbsOrigin(Entities:FindByName( nil, "trigger_teleport_11_1"):GetAbsOrigin())
	end

	GameRules:GetGameModeEntity():SetContextThink(string.format("TeleportThink_%d", caster:GetPlayerID()), 
	function()
		if caster:FindAbilityByName("wisp_teleport") == nil then
			caster:AddAbility("wisp_teleport")
			local ability = caster:FindAbilityByName("wisp_teleport")
			ability:SetLevel(1)
		end
	end,
	0.1)

	StartSoundEvent("Hero_Antimage.Blink_out", caster)

end


function GiveHide(data)	
	local hero = data.activator
	if (hero:FindAbilityByName("templar_assassin_meld") == nil) and (hero:GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
		hero:AddAbility("templar_assassin_meld")
		local ability = hero:FindAbilityByName("templar_assassin_meld")
		ability:SetLevel(1)
	end
end

function RemoveHide(data)
	local hero = data.activator
	local ability = hero:FindAbilityByName("templar_assassin_meld")
	if ability ~= nil then
		hero:RemoveAbility("templar_assassin_meld")
	end
end

function CreateSnapTrap(data)
	--data.target:SetHullRadius(60.0)
	data.target:SetForwardVector(data.caster:GetForwardVector())
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
				damage = 50,
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


function DestroyBuilding(data)
	local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, data.caster)
	StartSoundEvent("DOTA_Item.Maim", data.caster)
	data.caster:ForceKill(false)
end

function CreateWard(data)
	local unit = data.target
	--unit:SetHullRadius(60.0)
	unit:SetForwardVector(data.caster:GetForwardVector())
	local number = math.floor(unit:GetAbsOrigin().x)

	GameRules:GetGameModeEntity():SetContextThink(string.format("WardThink_%d",number), 
	function()
		if unit:IsNull() == false then
			DestroyBuilding({caster = unit})
		end
	end,
	60)	


end

