--[[
    Hero Wars - A Dota2 Custom Game Mode

	Created by bbqnoobstew. The intent of the license is to prevent others from ever monetizing Hero Wars. 
	Please create better versions based on this! Just don't ever sell it and give me credit where it's due.
	
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

--[[
Custom items script file.
Controls the items in npc_items_custom.txt
Original Author - bbqnoobstew (njg)
]]

print ("[HERO WARS] *** custom_items started *** custom_items.lua loaded.")

--[[
*** TOMES ***
]]

function item_tome_str(keys)
	local caster = keys.caster
	local statBonus = keys.bonus_stat
	--if caster.tome_str == nil then
	--	caster.tome_str = 0
	--end

	--caster:SetBaseStrength(caster:GetBaseStrength() - caster.tome_str)
	--caster.tome_str = caster.tome_str + statBonus
	--caster:SetBaseStrength(caster:GetBaseStrength() + caster.tome_str)

	caster:ModifyStrength(statBonus)

end
function item_tome_agi(keys)
	local caster = keys.caster
	local statBonus = keys.bonus_stat
	--if caster.tome_agi == nil then
	--	caster.tome_agi = 0
	--end

	--caster:SetBaseAgility(caster:GetBaseAgility() - caster.tome_agi)
	--caster.tome_agi = caster.tome_agi + statBonus
	--caster:SetBaseAgility(caster:GetBaseAgility() + caster.tome_agi)

	caster:ModifyAgility(statBonus)

end
function item_tome_int(keys)
	local caster = keys.caster
	local statBonus = keys.bonus_stat
	--if caster.tome_int == nil then
	--	caster.tome_int = 0
	--end

	--caster:SetBaseIntellect(caster:GetBaseIntellect() - caster.tome_int)
	--caster.tome_int = caster.tome_int + statBonus
	--caster:SetBaseIntellect(caster:GetBaseIntellect() + caster.tome_int)

	caster:ModifyIntellect(statBonus)

end

function item_tome_power(keys)
	local caster = keys.caster
	local statBonus = keys.bonus_stat
	--if caster.tome_int == nil then
	--	caster.tome_int = 0
	--end
	--if caster.tome_agi == nil then
	--	caster.tome_agi = 0
	--end
	--if caster.tome_str == nil then
	--	caster.tome_str = 0
	--end

	caster:ModifyStrength(statBonus)
	caster:ModifyAgility(statBonus)
	caster:ModifyIntellect(statBonus)
	--caster:SetBaseStrength(caster:GetBaseStrength() - caster.tome_str)
	--caster.tome_str = caster.tome_str + statBonus
	--caster:SetBaseStrength(caster:GetBaseStrength() + caster.tome_str)

	--caster:SetBaseAgility(caster:GetBaseAgility() - caster.tome_agi)
	--caster.tome_agi = caster.tome_agi + statBonus
	--caster:SetBaseAgility(caster:GetBaseAgility() + caster.tome_agi)

	--caster:SetBaseIntellect(caster:GetBaseIntellect() - caster.tome_int)
	--caster.tome_int = caster.tome_int + statBonus
	--caster:SetBaseIntellect(caster:GetBaseIntellect() + caster.tome_int)
end

function item_tome_exp(keys)
	local thisHero = EntIndexToHScript(keys.caster_entindex)
	thisHero:AddExperience(500,false, false)
end

function item_healing_pot(keys)
	keys.caster:GetPlayerOwner():GetAssignedHero():Heal(keys.heal_amount, keys.caster)
	--this looks neat, investigate
	-- local HealingPopUp = require("popups")
	-- PopupHealing(event.caster, event.heal_amount)
end

function item_mana_pot(keys)
	keys.caster:GetPlayerOwner():GetAssignedHero():GiveMana(keys.mana_amount)
	-- local HealingPopUp = require("popups")
	-- PopupHealing(event.caster, event.heal_amount)
end

--[[

*** SPELLS ***

]]
--[[Author: Pizzalol
	Date: 18.01.2015.
	Checks if the target is an illusion, if true then it kills it
	otherwise the target model gets swapped into a frog]]
function voodoo_start( keys )
	local target = keys.target
	local model = keys.model

	if target:IsIllusion() then
		target:ForceKill(true)
	else
		if target.target_model == nil then
			target.target_model = target:GetModelName()
		end

		target:SetOriginalModel(model)
	end
end

--[[Author: Pizzalol
	Date: 18.01.2015.
	Reverts the target model back to what it was]]
function voodoo_end( keys )
	local target = keys.target

	-- Checking for errors
	if target.target_model ~= nil then
		target:SetModel(target.target_model)
		target:SetOriginalModel(target.target_model)
	end
end

--[[
	Author: Noya
	Date: 25.01.2015.
	Creates a dummy unit to apply the Blizzard thinker modifier which does the waves
	TODO: This is broken to the point I'm tired of trying to fix it.
			Two things:
				1) This randomly causes the game to crash
				2) Sometimes the channeling gets stuck and allows the hero to walk away and the spell keeps going. Mostly happens around creeps. I can succesfully detect the erroneous waves
				with the WAVE_SAFETY_COUNT, but I can't stop the ability from firin. caster:HasModifier returns nil and errors out. The caster is npc_dota_hero_enchantress.
]]

function BlizzardStart( event )
	WAVE_SAFETY_COUNT = 0

	-- Variables
	-- print ("HWDEBUG: Starting the blizzard")
	local caster = event.caster
	-- print (caster:GetUnitName())
	local point = event.target_points[1]

	caster.blizzard_dummy = CreateUnitByName("dummy_unit_vulnerable", point, false, caster, caster, caster:GetTeam())
	event.ability:ApplyDataDrivenModifier(caster, caster.blizzard_dummy, "modifier_blizzard_thinker", nil)
end

-- -- Create the particles with small delays between each other
function BlizzardWave( event )
	-- print ("HWDEBUG: Starting the BlizzardWave")
	local caster = event.caster
	WAVE_SAFETY_COUNT = WAVE_SAFETY_COUNT + 1
    -- print (WAVE_SAFETY_COUNT)
    -- print (event.WaveCount)
    -- print (caster:GetUnitName())
    if WAVE_SAFETY_COUNT > event.WaveCount then
		if caster:HasModifer('modifier_blizzard_thinker') then
			--print ("caster still has modifier modifier_blizzard_thinker")
		end
	end

	local target_position = event.target:GetAbsOrigin() --event.target_points[1]
    local particleName = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
    local distance = 100

    -- Center explosion
    local particle1 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl( particle1, 0, target_position )

	local fv = caster:GetForwardVector()
    local distance = 100

    Timers:CreateTimer(0.05,function()
    local particle2 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
	 ParticleManager:SetParticleControl( particle2, 0, target_position+RandomVector(100) ) end)

    Timers:CreateTimer(0.1,function()
	local particle3 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
	 ParticleManager:SetParticleControl( particle3, 0, target_position-RandomVector(100) ) end)

    Timers:CreateTimer(0.15,function()
	local particle4 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
	 ParticleManager:SetParticleControl( particle4, 0, target_position+RandomVector(RandomInt(50,100)) ) end)

    Timers:CreateTimer(0.2,function()
	local particle5 = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, caster )
	 ParticleManager:SetParticleControl( particle5, 0, target_position-RandomVector(RandomInt(50,100)) ) end)

    --print(target_position)

end

function BlizzardEnd( event )
	local caster = event.caster

	caster.blizzard_dummy:RemoveSelf()
end


--[[
	Author: Noya
	Date: 17.01.2015.
	Bounces a chain lightning
]]
function ChainLightning( event )

	local hero = event.caster
	local target = event.target
	local ability = event.ability

	local damage = ability:GetLevelSpecialValueFor( "lightning_damage", ability:GetLevel() - 1 )
	local bounces = ability:GetLevelSpecialValueFor( "lightning_bounces", ability:GetLevel() - 1 )
	local bounce_range = ability:GetLevelSpecialValueFor( "bounce_range", ability:GetLevel() - 1 )
	local decay = ability:GetLevelSpecialValueFor( "lightning_decay", ability:GetLevel() - 1 ) * 0.01
	local time_between_bounces = ability:GetLevelSpecialValueFor( "time_between_bounces", ability:GetLevel() - 1 )

	local lightningBolt = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_WORLDORIGIN, hero)
	ParticleManager:SetParticleControl(lightningBolt,0,Vector(hero:GetAbsOrigin().x,hero:GetAbsOrigin().y,hero:GetAbsOrigin().z + hero:GetBoundingMaxs().z ))	
	ParticleManager:SetParticleControl(lightningBolt,1,Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,target:GetAbsOrigin().z + target:GetBoundingMaxs().z ))	
	--ParticleManager:SetParticleControlEnt(lightningBolt, 1, target, 1, "attach_hitloc", target:GetAbsOrigin(), true)

	EmitSoundOn("Hero_Zuus.ArcLightning.Target", target)	
	ApplyDamage({ victim = target, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
	PopupDamage(target,math.floor(damage))

	-- Every target struck by the chain is added to a list of targets struck, And set a boolean inside its index to be sure we don't hit it twice.
	local targetsStruck = {}
	target.struckByChain = true
	table.insert(targetsStruck,target)

	local dummy = nil
	local units = nil

	Timers:CreateTimer(DoUniqueString("ChainLightning"), {
		endTime = time_between_bounces,
		callback = function()
	
			-- unit selection and counting
			units = FindUnitsInRadius(hero:GetTeamNumber(), target:GetOrigin(), target, bounce_range, DOTA_UNIT_TARGET_TEAM_ENEMY, 
						DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, true)

			-- particle and dummy to start the chain
			targetVec = target:GetAbsOrigin()
			targetVec.z = target:GetAbsOrigin().z + target:GetBoundingMaxs().z
			if dummy ~= nil then
				dummy:RemoveSelf()
			end
			dummy = CreateUnitByName("dummy_unit", targetVec, false, hero, hero, hero:GetTeam())

			-- Track the possible targets to bounce from the units in radius
			local possibleTargetsBounce = {}
			for _,v in pairs(units) do
				if not v.struckByChain then
					table.insert(possibleTargetsBounce,v)
				end
			end

			-- Select one of those targets at random
			target = possibleTargetsBounce[math.random(1,#possibleTargetsBounce)]
			if target then
				target.struckByChain = true
				table.insert(targetsStruck,target)		
			else
				-- There's no more targets left to bounce, clear the struck table and end
				for _,v in pairs(targetsStruck) do
				    v.struckByChain = false
				    v = nil
				end
			    --print("End Chain, no more targets")
				return	
			end


			local lightningChain = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_WORLDORIGIN, dummy)
			ParticleManager:SetParticleControl(lightningChain,0,Vector(dummy:GetAbsOrigin().x,dummy:GetAbsOrigin().y,dummy:GetAbsOrigin().z + dummy:GetBoundingMaxs().z ))	
			
			-- damage and decay
			damage = damage - (damage*decay)
			ApplyDamage({ victim = target, attacker = hero, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			PopupDamage(target,math.floor(damage))
			--print("Bounce "..bounces.." Hit Unit "..target:GetEntityIndex().. " for "..damage.." damage")

			-- play the sound
			EmitSoundOn("Hero_Zuus.ArcLightning.Target",target)

			-- make the particle shoot to the target
			ParticleManager:SetParticleControl(lightningChain,1,Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,target:GetAbsOrigin().z + target:GetBoundingMaxs().z ))
	
			-- decrement remaining spell bounces
			bounces = bounces - 1

			-- fire the timer again if spell bounces remain
			if bounces > 0 then
				return time_between_bounces
			else
				for _,v in pairs(targetsStruck) do
				   	v.struckByChain = false
				   	v = nil
				end
				--print("End Chain, no more bounces")
			end
		end
	})
end


--[[
	Author: Noya
	Date: 21.01.2015.
	Kills a target, gives Health to the caster according to the sacrificed target current Health
]]
function DeathCoil( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local damage = ability:GetLevelSpecialValueFor( "target_damage" , ability:GetLevel() - 1 )
	local heal = ability:GetLevelSpecialValueFor( "heal_amount" , ability:GetLevel() - 1 )
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
	else
		target:Heal( heal, caster)
	end
end

-- Denies self cast, with a message
function DeathCoilPrecast( event )
	if event.target == event.caster then
		event.caster:Interrupt()
		FireGameEvent( 'custom_error_show', { player_ID = pID, _error = "Ability Can't Target Self" } )
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 26, 2015
	Called when the unit lands an attack on a target.  Applies a brief lifesteal modifier if not attacking a structure 
	(Lifesteal blocks in KV files will normally allow the unit to heal when attacking these).
================================================================================================================= ]]
function modifier_item_lifesteal_datadriven_on_orb_impact(keys)
	if keys.target.GetInvulnCount == nil then
		keys.ability:ApplyDataDrivenModifier(keys.attacker, keys.attacker, "modifier_item_lifesteal_datadriven_lifesteal", {duration = 0.03})
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: February 4, 2015
	Called when the unit lands an attack on a target.  Applies the modifier so long as the target is not a structure.
	Additional parameters: keys.ColdDurationMelee and keys.ColdDurationRanged
	**** MODIFIED by bbqnoobstew
================================================================================================================= ]]
function modifier_item_skadi_datadriven_on_orb_impact(keys)
	if keys.target.GetInvulnCount == nil then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_skadi_datadriven_cold_attack", {duration = keys.ColdDuration})
	end
end


function Thorns( keys )
	--print ("HWDEBUG: thorns called")
	-- Variables
	--print ("damage taken = " .. keys.DamageTaken)
	local caster = keys.caster
	local attacker = keys.attacker
	local ability = keys.ability
	local casterSTR = caster:GetStrength()
	local damageTaken = keys.DamageTaken

	--local str_return = ability:GetLevelSpecialValueFor( "strength_pct" , ability:GetLevel() - 1  ) * 0.01
	--local damage = ability:GetLevelSpecialValueFor( "return_damage" , ability:GetLevel() - 1  )

	local thornsDamage = damageTaken * 0.1
	local damageType = ability:GetAbilityDamageType()

	-- Damage
	ApplyDamage({ victim = attacker, attacker = caster, damage = thornsDamage, damage_type = damageType })

	--print ("HWDEBUG: Thorns return damage was: " .. thornsDamage)

end