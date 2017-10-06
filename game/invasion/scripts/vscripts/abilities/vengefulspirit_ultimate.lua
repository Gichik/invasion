
vengefulspirit_ultimate = class({})

LinkLuaModifier("modifier_no_damage_physical", "modifiers/modifier_no_damage_physical.lua", LUA_MODIFIER_MOTION_NONE )

function vengefulspirit_ultimate:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1 
end

 
 function vengefulspirit_ultimate:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING 
     return behav
 end

 function vengefulspirit_ultimate:GetAOERadius()
     return self:GetSpecialValueFor("radius")
 end

function vengefulspirit_ultimate:OnSpellStart()

	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local duration = self:GetDuration()

	EmitSoundOn("Hero_ArcWarden.MagneticField.Cast", self:GetCaster())
	for i = 0, (duration-5), 5 do
	 GameRules:GetGameModeEntity():SetContextThink(string.format("vengefulspirit_ultimate_sound_%d", i), 
        function()
        	EmitSoundOn("Hero_ArcWarden.MagneticField", self:GetCaster())	
	    return nil
        end,
        i)
	end	

	for i = 0, (4*duration), 1 do
	 GameRules:GetGameModeEntity():SetContextThink(string.format("vengefulspirit_ultimate_%d", i), 
        function()
	        id1 = ParticleManager:CreateParticle("particles/econ/items/faceless_void/faceless_void_mace_of_aeons/fv_chronosphere_aeons_g.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControl( id1, 0, point)
			
			local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, self:GetSpecialValueFor("radius") ,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
			
			for i = 1, #units do		
				if units[ i ] then 
						units[ i ]:AddNewModifier(caster, self, "modifier_no_damage_physical", {duration = 0.5})			
				end
			end

	        return nil
        end,
        i/4)
	end	

end

function vengefulspirit_ultimate:IsStealable()
	return false
end

function vengefulspirit_ultimate:IsHiddenWhenStolen()
	return true
end

