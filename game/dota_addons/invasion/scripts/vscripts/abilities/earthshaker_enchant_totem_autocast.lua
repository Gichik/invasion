earthshaker_enchant_totem_autocast = class({})


function earthshaker_enchant_totem_autocast:GetCastAnimation()	
    return ACT_DOTA_CAST_ABILITY_2 
end

function earthshaker_enchant_totem_autocast:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AUTOCAST 
    return behav
end


function earthshaker_enchant_totem_autocast:OnSpellStart()
 	local ability = self:GetCaster():FindAbilityByName("earthshaker_enchant_totem")
 	ability:CastAbility()
end


function earthshaker_enchant_totem_autocast:OnUpgrade()

 	local ability = self:GetCaster():FindAbilityByName("earthshaker_enchant_totem")
	ability:UpgradeAbility(false)
		
 	if self:GetLevel() == 1 then
		GameRules:GetGameModeEntity():SetContextThink("earthshaker_enchant_totem_autocast", 
			function()
			 	if self:GetAutoCastState() then
			 		self:CastAbility()
			 	end
			return 1
			end,
			1)
	end

end

function earthshaker_enchant_totem_autocast:IsStealable()
	return false
end

function earthshaker_enchant_totem_autocast:IsHiddenWhenStolen()
	return true
end