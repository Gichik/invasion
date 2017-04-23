
wisp_heal = class({})


 function wisp_heal:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
     return behav
 end

function wisp_heal:OnSpellStart()

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	
	if target ~= caster then	
		EmitSoundOn("Hero_Oracle.PurifyingFlames.Damage", self:GetCaster())
		wisp_heal:Animation(self)
		wisp_heal:Heal(self)
	else
		self:EndCooldown()
	end
end


function wisp_heal:Animation(self)

	local target =  self:GetCursorTarget()
	ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	

end


function wisp_heal:Heal(self)
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	
	if target ~= caster then

		ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
		local id = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
		GameRules:GetGameModeEntity():SetContextThink(string.format("WispFirstHeal_%d",caster:GetPlayerID()), 
		function()
			ParticleManager:DestroyParticle(id, false)
		end,
		6)	

		for i = 1, 6 do 
			GameRules:GetGameModeEntity():SetContextThink(string.format("WispSecondHeal_%d", caster:GetPlayerID()+i), 
			function()
				target:Heal(10,caster)
				local pidx = ParticleManager:CreateParticle("particles/msg_fx/msg_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
				ParticleManager:SetParticleControl(pidx, 1, Vector( POPUP_SYMBOL_PRE_PLUS, 10, 0 ) )
	  			ParticleManager:SetParticleControl(pidx, 2, Vector(3, 3, 0))
	  			ParticleManager:SetParticleControl(pidx, 3, Vector(61,223,88))
			end,
			i)
		end
		
	end
	
end

