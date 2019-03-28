--outputid
--caller
--activator


function TeleportTrigger(data)
	--print("TeleportTrigger")

	local caller = data.caller:GetName()
	local point = Entities:FindByName( nil, "hero_teleport_point_1"):GetAbsOrigin()
	local activator = data.activator

	if caller == "trigger_teleport_1" then
		point = Entities:FindByName( nil, "hero_teleport_point_2"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_2" then
		point = Entities:FindByName( nil, "hero_teleport_point_1"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_3" then
		point = Entities:FindByName( nil, "hero_teleport_point_4"):GetAbsOrigin()
	end

	if caller == "trigger_teleport_4" then
		point = Entities:FindByName( nil, "hero_teleport_point_3"):GetAbsOrigin()
	end	

	activator:SetAbsOrigin(point) 
	FindClearSpaceForUnit(activator, point, false) 
	activator:Stop()
	FocusCameraOnPlayer(activator)

	if activator.controllableUnit then
		if not activator.controllableUnit:IsNull() then
			if activator.controllableUnit:IsAlive() then
				activator.controllableUnit:SetAbsOrigin(point) 
				FindClearSpaceForUnit(activator.controllableUnit, point, false) 
				activator.controllableUnit:Stop()
			end
		end
	end

end


function FocusCameraOnPlayer(player)
    PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
    Timers:CreateTimer(1, function()
        PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)
        return nil
    end
    )
end
