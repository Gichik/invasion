

--[[
Определяем саму убилку как самостоятельный класс, подонбо как опредееляем переменные.
]]
if grimstroke_custom == nil then
	grimstroke_custom = class({})
end

--[[
Определяем тип умения, непосредственно каст на точку. 
]] 
function grimstroke_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT
end


--[[
Определяем тип урона умения, у нас магический. 
]] 
function grimstroke_custom:GetAbilityDamageType()	
	return DAMAGE_TYPE_MAGICAL
end


--[[
Этот метод, OnAbilityPhaseStart, имеет приоритет выше, чем OnSpellStart.
Соответственно, он запускается раньше. 
В большинстве случаев его не используют при создании умений,
и если его не переопределять, то он самостоятельно запускает OnSpellStart. 
Но наше умение будет использовать звук, который почему-то в  OnSpellStart идет с задержкой.
Поэтому пришлось переопределить метод OnAbilityPhaseStart() и перенестив  него часть логики.

Напоминаю, что "self" - это то-ли указатель, то-ли переменная, хранящая сам класс абилки.
Знатоки пояснят этот момент лучше, вам достаточно знать, что можно в классе абилки создавать
собственные переменные, дабы было удобнее хранить данные.

Логика простая: 
1)сохраняем героя, кастующего спелл в сосбвтенную преемнную  self.caster.
2)Останавливаем его, если он двигался через API метод Stop().
4)Заставялем его проиграть анимацию через API метод StartGesture().
5)Проигрываем звук каста через API метод EmitSound().
6)Отрисовываем партикли - эффекты анимации через API ParticleManager.
7)Запускаем логику самого умения.

]] 
function grimstroke_custom:OnAbilityPhaseStart()
	self.caster = self:GetCaster()
	self.caster:Stop()
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self.caster:EmitSound("Hero_Grimstroke.DarkArtistry.PreCastPoint")
	ParticleManager:CreateParticle("particles/units/heroes/hero_grimstroke/grimstroke_loadout.vpcf", PATTACH_ABSORIGIN, self.caster)			
	self:OnSpellStart()
end


--[[

Переменные, значения которых берем из DataDriven  (npc_abilities_custom.txt):
self.dmg - наша собственная переменная, в которой будем хранить урон умения.
self.dmgMultiple - наша собственная переменная, в которой будем хранить множитель урона.
self.range - наша собственная переменная, в которой будем хранить дистанцию полета снаряда.

Всопмогательные переменные:
self.targetTable - наш собственный массив, в котором будем хранить задетых снарядом юнитов.
self.vDirection - наша собственная переменная, в которую поместим вектор движения снаряда
иными словами: берем координаты точки каста умения, берем координаты точки расположения героя кастующего
находим их разницу, нормализуем API методом Normalized() и получаем	вектор движения.
Грамотеи математики меня поправят, сам я плох в ней.

Логика умения:
Далее идует объяснение некоторых механик программирования. 
Знатоки забросают меня камнями, если я не предупрежу, что это ПРОИЗВОЛЬНЫЕ объяснения.
Можете в комментаах пояснить лучше, пойдет на пользу всем.

Когда мы нажимаем на кнопку каста умения, идет его обработка как на сервере, так и на клиенте.
Иными словами, мы как будто два раза кастуем одно и то же умение. 
Поэтому нужно разделять код, который отработает клиент, а какой сервер. Иначе получим даблкаст.

Проверяем, вызван ли метод OnSpellStart() на сервере через оператор условия "if IsServer() then end".
Делаем это для того, чтобы умение скастовалось всего один раз, когда его будет обрабатывать именно сервер.
Почему именно на сервере реализуем дальнейшую логику? Да йух знает, там вроде обширнее база API.

После проверки запускаем таймер, который любезно на всеобщее пользование выложил BMD.
Указываем в его параметрах запуск через 8 милисекунд. А так же код нашей функции.

В функции мы создаем лоакльную переменную data, что является таблицей данных,
которые необходимы для дальнейшго создания снаряда.

Снаряд можно генерировать двух типов:
LinearProjectile - летит прост по вектору заданную дистанцию. 
TrackingProjectile - летит до заданной цели (объекта).

Нам нужен LinearProjectile, пожтому после того, как задали data, создаем снаряд
с помощью API ProjectileManager:CreateLinearProjectile().

Ну и парочку звуков там еще проигрываем. через API метод EmitSound().

Подробнее про data (знатоки поправят, сам я толком не разбирался в значении каждого параметра):
EffectName - партикль снаряда
Ability - умение, которое будет отвечать за снаряд и его поведение.
Source - источник, герой.
vSpawnOrigin - точка создания снаряда.
vVelocity - вв переводе скорость, по факту одновременно и вектор направления и скорость полета.
fStartRadius - начальный радиус снаряда (ну тип в каком диапазоне касатсься других объектов, хитбоксы и все такое...)
fEndRadius  - радиус снаряда в конечной точке 
fDistance - дистанция полета снаряда
iUnitTargetTeams - юнитов какой тимы "задевать" (отлавливать) при полете
iUnitTargetTypes - тип этих юнитов
iUnitTargetFlags - флаги всякие, вроде уязвимых к магии
iVisionTeamNumber - какой тиме давать обзор полета снаряда
iVisionRadius - сам радиус обзора
 ]]

function grimstroke_custom:OnSpellStart()
	
	self.dmg = self:GetSpecialValueFor("damage")
	self.dmgMultiple = self:GetSpecialValueFor("damage_multiply") 
	self.range = self:GetSpecialValueFor("cast_range") 

	self.targetTable = {}	
	self.vDirection = self:GetCursorPosition()	- self.caster:GetAbsOrigin()
	self.vDirection = self.vDirection:Normalized()	

	if IsServer() then
	    Timers:CreateTimer(0.8, function()

			local data = {
				EffectName	= "particles/units/heroes/hero_demonartist/demonartist_darkartistry_proj.vpcf",
				Ability = self,
				Source = self.caster,
				vSpawnOrigin = self.caster:GetAbsOrigin(),
				vVelocity = self.vDirection * 2700 * 0.7, 
				fStartRadius = 120,
				fEndRadius = 160,
				fDistance = self.range,
				iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iVisionTeamNumber = self.caster:GetTeamNumber(),
				iVisionRadius = 100,
			}

			self.caster:EmitSound("Hero_Grimstroke.DarkArtistry.Cast.Layer")
			self.caster:EmitSound("Hero_Grimstroke.DarkArtistry.Cast")	
			self.caster:EmitSound("Hero_Grimstroke.DarkArtistry.Projectile")
			ProjectileManager:CreateLinearProjectile( data )
	    end
	    )
	end

end



--[[
OnProjectileThink - метод, что отрабатывает каждую координату полета снаряда.
Так как мы в data указали в качестве родителя (Ability) снаряда саму абилку, мы можем
обрабатывать его полет вот таким вот образом.

vLocation - переменная извне, от сервера, которая несет в себе текущую координату снаряда.

Логика:
Проверяем, существует (живой или мертвый) герой, что кастовал абилку. 
Если нет, то я просто ничего не делаю (не наношу урон, и т.п.).
Если все же существует, то:

1)Даю обзор полета снаряда команде игрока. По идеи за это должен отвчать iVisionRadius из data,
но почему-то он этого не делал и я с помощью API метода AddFOWViewer решил этот вопрос.
2)Ищу существ вблизи снаряда через API метод FindUnitsInRadius.
3)Проверяю, нашлись ли такие и если да, то ппроверяю, нет ли его в targetTable. 
напоминаю, что в этом массиве я храню как раз таки юнитов, которых снаряд уже имел честь
задеть один раз. Без этого массива не обойтись, ибо юниты имеют свой радиуес "жирности",
иными словами, сразу несоклько точек обхватывают на плоскости. Поэтому чтобы два раза не
считать одного юнита при подсчете конечного урона, мы и создали targetTable.

Так вот, если юнит есть в targetTable, то есть я уже обрабатывал это столккновение,
то далее прерываю код методом "return". Иными словами, выхожу из обработки полета снаряда.

Если же юнита нет в таблице, я его туда заношу через Lua функцию table.insert()
Далее увеличиваю показатель урона умения множителем урона.
Но перед этим проверяю, что self.targetTable > 1. Зачем? Чтобы первый юнит, который встретит снаряд,
получил именно базовый урон, а не увеличенный (как второй и т.д.). 
Можно было бы конечно иначе обойти этот момент, но я решил так.

Далее мы непосредственно наносим урон юниту через API метод ApplyDamage().
Ну и рисуем всякие эффекты там на юните, да и звук столкновения.
]]
function  grimstroke_custom:OnProjectileThink(vLocation)

	if self:GetCaster() then

		AddFOWViewer(self.caster:GetTeamNumber(), vLocation, 10, 0.2, false)

		local units = FindUnitsInRadius( self.caster:GetTeamNumber(), vLocation, self.caster, 100,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

		if units then  
			for i = 1, #units do

				if units[i] then
					for j = 0, #self.targetTable do
						if self.targetTable[j] == units[i] then 
							return nil
						end
					end

					table.insert(self.targetTable, units[i]) 

					if #self.targetTable > 1 then
						self.dmg = self.dmg + self.dmgMultiple 
					end

					ApplyDamage({
					    victim = units[i],
					    attacker = self.caster,
					    damage = self.dmg,
					    damage_type = self:GetAbilityDamageType(),
					    ability = self
					   })

					ParticleManager:CreateParticle("particles/units/heroes/hero_demonartist/demonartist_darkartistry_dmg_stroke_tgt.vpcf", PATTACH_ABSORIGIN, units[i])
					ParticleManager:CreateParticle("particles/units/heroes/hero_demonartist/demonartist_darkartistry_dmg_steam.vpcf", PATTACH_ABSORIGIN, units[i])			
					units[i]:EmitSound("Hero_Grimstroke.DarkArtistry.Damage")
				end
			end	
		end

	end

end