
intent_look = class({})


 function intent_look:GetAOERadius()
     return self:GetSpecialValueFor("radius")
 end

 function intent_look:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
     return behav
 end


function intent_look:OnSpellStart()
	EmitSoundOn("DOTA_Item.DustOfAppearance.Activate", self:GetCaster())
	intent_look:Animation(self)
	intent_look:Damage(self)
end


function intent_look:Animation(self)

	local point =  self:GetCursorPosition()
	local id1 = ParticleManager:CreateParticle("particles/items_fx/dust_of_appearance.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( id1, 0, point)	

end


function intent_look:Damage(self)
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, self:GetSpecialValueFor("radius") ,
	DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #units do		
		if units[ i ] then 
			units[ i ]:AddNewModifier( caster, self, "modifier_truesight", {duration = 7} )			
		end
	end
	
end