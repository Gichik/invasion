
if item_bag_of_gold == nil then
	item_bag_of_gold = class({})
end

function item_bag_of_gold:OnSpellStart()
	if IsServer() then
		for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
			if PlayerResource:IsValidPlayerID(playerID) then
				PlayerResource:ModifyGold(playerID, 1000, true, DOTA_ModifyGold_SharedGold)
				EmitSoundOnClient( "General.Coins", PlayerResource:GetPlayer(playerID))
				SendOverheadEventMessage( PlayerResource:GetPlayer(playerID), OVERHEAD_ALERT_GOLD, PlayerResource:GetPlayer(playerID), 1000, nil )
			end
		end
		UTIL_Remove(self:GetContainer())
		UTIL_Remove(self)
	end
end

