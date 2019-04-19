
if item_armageddon_bag_of_gold == nil then
	item_armageddon_bag_of_gold = class({})
end

function item_armageddon_bag_of_gold:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		hCaster:ModifyGold(30, true, DOTA_ModifyGold_SharedGold)
		EmitSoundOnClient( "General.Coins", hCaster)
		SendOverheadEventMessage( hCaster, OVERHEAD_ALERT_GOLD, hCaster, 30, nil )

		UTIL_Remove(self:GetContainer())
		UTIL_Remove(self)
	end
end

