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
Custom Abilities
Controls all abilities in npc_abilities_custom.txt
Original Author - bbqnoobstew (njg)
]]

require ( "../utils/buildinghelper")
print ("[HERO WARS] *** custom_abilities started *** custom_abilities.lua loaded.")

--constant to ensure that resources arent refunded if the ability was stopped by code - meaning the player didn't meet a criteria so nothing was ever charged
bAbilityWasStopped = false

--[[
*** DEBUG FUNCTIONS ***
]]

function debugEcho(keys)
--Used for debugging purposed.
--Currently not in use.

	print ("HWDEBUG: *** OnUpgrade was called for debugEcho Custom Ability*** ")
	-- print (keys.caster)
	-- print (keys.caster:GetUnitName())
end

function debugEcho2(keys)
--Used for debugging purposed.
--Currently not in use.
	print("HWDEBUG: *** THE BUTTON WAS PUSHED ON THE CUSTOM UNIT/BUILDING ***")
	print("HWDEBUG: Testing some debug when button pressed...")
	print (keys.caster:GetUnitName()) -- already know this is the npc_dota_town_hall
	print (keys.attacker:GetUnitName()) -- also npc_dota_town_hall
	print (keys.unit:GetUnitName()) -- also npc_dota_town_hall

	--ok set the owner in herowars.lua - now can I get the player from getting at the objects owner? We'll see in a few.
	local ownerPlayerID = keys.caster:GetOwner():GetPlayerID() -- get the playerID from the owner
	local ownerHero = keys.caster:GetOwner():GetAssignedHero() -- get the Hero from the owner (testing to see which handle it is)
	print("The owners PlayerID: " .. ownerPlayerID)
	print("The owners assigned hero's gold (to test if GetAssigned Hero returns the  CDOTA_BaseNPC_Hero type: " .. ownerHero:GetGold())
	--print(keys.caster:GetOwner():GetGold()) -- another test to see which handle is being referenced. This is for CDOTA_BaseNPC_Hero - i doubt
	--this will work (doubt)

	--can't do this yet, will need to get the HScript first
	-- er can't do this ever - the caster is a  CDOTA_BaseNPC  and our GetGold is a CDOTA_BaseNPC_Hero which extends CODATA_BaseNPC.
	--print(keys.caster:GetGold())

	--test accessing HeroWarsGameMode data
	--HeroWarsGameMode:_debugPlayersInfo()
	print("HWDEBUG: Printing HeroWarsGameMode.vPlayerHeroData")
	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		for i,v in pairs(heroData) do print (i, v) end
		-- if heroData.nPlayerID == 0 then
		-- 	heroData.nConsumedFood = heroData.nConsumedFood + 1
		-- end
	end

	print("HWDEBUG: Searching for the properties of npc_dota_spawner_good_mid")

	---3 - FindAllByClassname - npc_dota_creature
	--testing b/c this is what is in the npc_units_custom.txt
	--"BaseClass"					"npc_dota_creature"
    local allFoundEntities = Entities:FindAllByClassname("npc_dota_spawner_good_mid")
	print ("Entities via FindAllByClassname(\"npc_dota_spawner_good_mid\")")
	print ("Entries in table:")
	print (#allFoundEntities)

	for l, thisEntity in pairs(allFoundEntities) do
		print ("GetName()")
		print(thisEntity:GetName())
		print ("EntityHandle()")
		print(thisEntity:GetEntityHandle())
		print ("GetTeamNumber()")
		--print(thisEntity:GetEntityIndex())
		print ("GetUnitName()")
		--print(thisEntity:GetUnitName())
		print("*** DeepPrintTable ***")
		DeepPrintTable(thisEntity)
		local thisSpawner = EntIndexToHScript(thisEntity:GetEntityIndex())
		print ("*** DeepPrintTable - thisSpawner ***")
		DeepPrintTable(thisSpawner)
		for k, v in ipairs(thisSpawner) do print (k,v) end
	end
end

function debugGold(keys)
--Used for debugging purposed. Returns how much gold a hero has.
--Currently not in use.
	print("HWDEBUG: $$$BUTTON$$$ - The \"Gold\" button was pressed")
	local cost = keys.GoldCost
	local ownerHero = keys.caster:GetOwner():GetAssignedHero()
	print("Gold at the start = " .. ownerHero:GetGold())
	print("Ability cost = " .. cost)
	--hero:ModifyGold( nAmount, true, 0 )
end

--[[
*** RESOURCE CHECKING AND CONSUMPTION ***
]]

function ConsumeResources(keys)
--@params
--keys (goldCost, foodCost, woodCost, UnitName, other values specific to 'keys')
--Called by OnSpellStart
--Determines if the player has enough gold/food/wood to use an ability. If so, consumes it. If not, stops the ability from proceeding to channeling. Also performs round checking for Superior archer and duplicate checking for Bank
--Returns: Nothing
	local owner = keys.caster:GetOwner() --handle
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int
	-- get the players hero handle
	local ownerHero = owner:GetAssignedHero() --handle
	-- store the cost of the ability
	local goldCost = keys.GoldCost --int
	local foodCost = keys.FoodCost --int
	local woodCost = keys.WoodCost --int
	if woodCost == nil then
		--set the woodcost to nothing here so i dont have to set every single unit to a wood cost
		woodCost = 0
	end

	local unitName = keys.UnitName --string ""
	-- store the player gold for less typing
	local playerGold = ownerHero:GetGold() --int


	if unitName == "npc_dota_unit_peon" then
		if HeroWarsGameMode.nRoundNumber > 1 then
			unitName = "npc_dota_unit_master_peon"
			goldCost = keys.lvltwo_GoldCost
		end
	end

	if unitName == "npc_dota_unit_mortar_team" then
		if HeroWarsGameMode.nRoundNumber > 2 then
			unitName = "npc_dota_unit_bomb_squad"
			goldCost = keys.lvltwo_GoldCost
		end
	end

	if unitName == "npc_dota_wave_windigo" then
		if HeroWarsGameMode.nRoundNumber >= 2 and HeroWarsGameMode.nRoundNumber <= 3 then
			--unitName = "npc_dota_wave_windigo_brat"
			goldCost = keys.lvltwo_GoldCost
		elseif HeroWarsGameMode.nRoundNumber > 3 then
			--unitName = "npc_dota_wave_hydralisk"
			goldCost = keys.lvlthree_GoldCost
		end
	end

	if unitName == "npc_dota_unit_sup_archer" then
		if HeroWarsGameMode.nRoundNumber < 3 then
			print ("HWDEBUG: Superior archer not available unit round 3.")
			keys.caster:Stop()
			bAbilityWasStopped = true
			return
		end
	end


	if not CheckGold(playerGold, goldCost) then
		print ("HWERROR: Not enough gold")
		keys.caster:Stop()
		bAbilityWasStopped = true
		return
	end
	if not CheckFood(ownerPlayerID, foodCost) then
		print("HWERROR: Not enough food")
		keys.caster:Stop()
		bAbilityWasStopped = true
		return
	end
	if not CheckWood(ownerPlayerID, woodCost) then
		print("HWERROR: Not enough gold")
		keys.caster:Stop()
		bAbilityWasStopped = true
		return
	end

	--if we have enough resources, check to see if its a building, then check to see if we can add it to the grid
	if BUILDABLE_BUILDINGS[keys.UnitName] then
		if not AddBuildingPoint(keys) then
			print("HWERROR: Not enough gold")
			keys.caster:Stop()
			bAbilityWasStopped = true
			return
		end
	end

	--perform a check there to see if we are building a bank and if the player already has a bank. If they do, do not allow another.
	if unitName == "npc_dota_player_bank" then
		print("HWDEBUG: Check to see if the player already has a bank...")
		for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
			if heroData.nPlayerID == ownerPlayerID then
				--our player id matches the vPlayerHeroData player id, so lets modify this entry
				--first check if we can consume the food
				--if our already consumed food plus the food cost of this item is greater than our max food return false
				if heroData.bHasBank then
					print("HWERROR: Player already has a bank, can't build two.")
					keys.caster:Stop()
					bAbilityWasStopped = true
					return
				end
			end
		end
	end

	ConsumeGold(ownerHero, goldCost)
	ConsumeFood(ownerPlayerID, foodCost)
	ConsumeWood(ownerPlayerID, woodCost)
end

function RefundResources(keys)
--@params
--keys (goldCost, foodCost, woodCost, UnitName, other values specific to 'keys')
--Called by OnChannelInterrupted
--Refunds the gold/food/wood consumed by ConsumeResources (clicking on ability abilty) and the channeling interrupted. Has a boolean to return if the ability was stopped by code due to lack of resources
--Returns: Nothing
	if bAbilityWasStopped then
		bAbilityWasStopped = false
		return
	end

	local owner = keys.caster:GetOwner() --handle
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int
	-- get the players hero handle
	local ownerHero = owner:GetAssignedHero() --handle
	-- store the cost of the ability
	local goldCost = keys.GoldCost --int
	local foodCost = keys.FoodCost --int
	local woodCost = keys.WoodCost --int
	if woodCost == nil then
		--set the woodcost to nothing here so i dont have to set every single unit to a wood cost
		woodCost = 0
	end

	local unitName = keys.UnitName --string ""
	-- store the player gold for less typing
	local playerGold = ownerHero:GetGold() --int


	if unitName == "npc_dota_unit_peon" then
		if HeroWarsGameMode.nRoundNumber > 1 then
			unitName = "npc_dota_unit_master_peon"
			goldCost = keys.lvltwo_GoldCost
		end
	end

	if unitName == "npc_dota_unit_mortar_team" then
		if HeroWarsGameMode.nRoundNumber > 2 then
			unitName = "npc_dota_unit_bomb_squad"
			goldCost = keys.lvltwo_GoldCost
		end
	end

	RefundGold(ownerHero, goldCost)
	--RefundFood(ownerPlayerID, foodCost)
	RefundWood(ownerPlayerID, woodCost)
	if BUILDABLE_BUILDINGS[keys.UnitName] then
		farm:RemoveBuilding(true)
	end
end

function RefundGold(ownerHero, goldCost)
--@params
--ownerHero - the Hero that owns the unit/building that invoked this ability
--goldCost - the gold cost of the ability
--Called by RefundResources
--Performs the refunding of gold
--Returns: Nothing
	print ("HWDEBUG: The player was refunded gold.")
	ownerHero:ModifyGold(goldCost, false, 0)
end

function RefundWood(ownerPlayerID, woodCost)
--@params
--ownerPlayerID - the Hero pLayer id that owns the unit/building that invoked this ability
--woodCost - the wood cost of the ability
--Called by RefundResources
--Performs the refunding of wood
--Returns: Nothing
	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		--for i,v in pairs(heroData) do print (i, v) end
		if heroData.nPlayerID == ownerPlayerID then
			--we can consume the requested food
			--print to the user their current food.
			heroData.nTotalWood = heroData.nTotalWood + woodCost
			print ("HWDEBUG: Hero was refunded wood, total wood:")
			print (heroData.nTotalWood)
			HeroWarsGameMode:UpdatePlayerWood(ownerPlayerID)
			return
		end
	end
end

function RefundFood(ownerPlayerID, foodCost)
--@params
--ownerPlayerID - the Hero pLayer id that owns the unit/building that invoked this ability
--foodCost - the food cost of the ability
--Called by RefundResources
--Performs the refunding of food (in this case the subtraction of the cost of the unit/building from the total food)
--Returns: Nothing
	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		if heroData.nPlayerID == ownerPlayerID then
			heroData.nConsumedFood = heroData.nConsumedFood - foodCost
			print ("HWDEBUG: Hero was refunded Food, total Food:")
			print (heroData.nConsumedFood)
		end
	end
end

function CheckGold(playerGold, goldCost)
--@params
--ownerHero - the Hero that owns the unit/building that invoked this ability
--goldCost - the gold cost of the ability
--Called by ConsumeResources
--Checks to see if the player has enough gold to use the ability.
--Returns: true or false

	--if we can consume the gold, return true, else return false if we cant
	if playerGold > goldCost then
		return true
	else
		return false
	end
end

function ConsumeGold(ownerHero, goldCost)
--@params
--ownerHero - the Hero that owns the unit/building that invoked this ability
--goldCost - the gold cost of the ability
--Called by ConsumeResources
--Spends money
--Returns: nothing
	ownerHero:SpendGold(goldCost, 5)
end

function CheckFood(nPlayerID, foodCost)
--@params
--ownerHero - the Hero that owns the unit/building that invoked this ability
--foodCost - the gold cost of the ability
--Called by ConsumeResources
--Checks to see if the player has enough food to use the ability.
--Returns: true or false

	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		if heroData.nPlayerID == nPlayerID then
			--if our already consumed food plus the food cost of this item is greater than our max food return false
			if heroData.nConsumedFood + foodCost > heroData.nMaxFood then
				print ("HWERROR: Hero does not have enough food!")
				return false
			else
				return true
			end
		end
	end
end

function ConsumeFood(nPlayerID, foodCost)
--@params
--nPlayerID - the Hero player id that owns the unit/building that invoked this ability
--foodCost - the food cost of the ability
--Called by ConsumeResources
--Adds the foodCost to the total amount of consumed food, which is limited to 19
--Returns: nothing

	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		--for i,v in pairs(heroData) do print (i, v) end
		if heroData.nPlayerID == nPlayerID then
			heroData.nConsumedFood = heroData.nConsumedFood + foodCost
			print ("HWDEBUG: Hero has enough food left (amount consumed):")
			print (heroData.nConsumedFood)
			--notify the UI that food has been consumed
			HeroWarsGameMode:UpdatePlayerFood(nPlayerID)
			return
		end
	end


end

function CheckWood(nPlayerID, woodCost)
--@params
--nPlayerID - the Hero player id that owns the unit/building that invoked this ability
--woodCost - the wood cost of the ability
--Called by ConsumeResources
--Checks to see if the player has enough wood to use the ability.
--Returns: true or false

	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		--for i,v in pairs(heroData) do print (i, v) end
		if heroData.nPlayerID == nPlayerID then
			if woodCost > heroData.nTotalWood then
				print ("HWDEBUG: Hero does not have enough wood!")
				return false
			else
				return true
			end
		end
	end
end

function ConsumeWood(nPlayerID, woodCost)
--@params
--nPlayerID - the Hero player id that owns the unit/building that invoked this ability
--woodCost - the wood cost of the ability
--Called by ConsumeResources
--Uses up a limited, non replenishable amount of wood
--Returns: nothing

	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		if heroData.nPlayerID == nPlayerID then
			heroData.nTotalWood = heroData.nTotalWood - woodCost
			print ("HWDEBUG: Hero has enough wood:")
			print (heroData.nTotalWood)
			HeroWarsGameMode:UpdatePlayerWood(nPlayerID)
			return
		end
	end
end

--[[
*** TRAIN/BUILD UNITS ***
]]

function TrainUnit(keys)
--@params
--keys.UnitName - The name of the unit to be trained
--Called by OnChannelSucceeded
--Trains a unit as specified by various abilities at the Barracks. All resource/interruption checking has been completed at this point. Create the unit 250 units away from the barracks.
--Returns: nothing

	--[[
	Trains the actual unit. This comes after checks for gold/food/wood and after the channeling succeeds.
	]]
	--print("HWDEBUG: $$$BUTTON$$$ - The Train Unit button was pressed.")

	--gathering player information for the clicker of the button
	-- get the player owner
	local owner = keys.caster:GetOwner() --handle
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int

	local unitName = keys.UnitName --string ""
	if unitName == "npc_dota_unit_peon" then
		if HeroWarsGameMode.nRoundNumber > 1 then
			unitName = "npc_dota_unit_master_peon"
		end
	end

	if unitName == "npc_dota_unit_mortar_team" then
		if HeroWarsGameMode.nRoundNumber > 2 then
			unitName = "npc_dota_unit_bomb_squad"
		end
	end

	--spawn the creep at at offset away from the building
	local spawnOffset = -250
	local spawnOffsetVector = Vector(0, spawnOffset, 0)
	local spawnLocation = keys.caster:GetAbsOrigin() + spawnOffsetVector
	local unit = CreateUnitByName(unitName, spawnLocation, true, nil, nil, keys.caster:GetTeam())

	--set the owner of the unit trained
	unit:SetOwner(owner)

	--make 'em controllable
	unit:SetControllableByPlayer(ownerPlayerID, true )
end

function AddBuildingPoint(keys)
--@params
--keys.UnitName - the name of the building to be built
--keys.caster:GetOwner - the owner so we can assign the build to their ownership
--keys.caster:GetPlayerID - the playerID so we can set the tower controllable by the player
--keys.ability:GetChannelTime()*.65 - this is the building helper build time of the building, the channel time scaled by a constant
--Returns
--false if we can't build there
--true if the building was successfully placed
	buildingPoint = BuildingHelper:AddBuildingToGrid(keys.target_points[1], 2, keys.caster) --2.34 is based on 150x150
	if buildingPoint == -1 then
		return false
	else
		local buildingName = keys.UnitName --string ""
		local owner = keys.caster:GetOwner() --handle
		local ownerPlayerID = owner:GetPlayerID() --int
		local buildTime = keys.ability:GetChannelTime()*.65
		farm = CreateUnitByName(buildingName, buildingPoint, false, nil, nil, keys.caster:GetTeam())
		BuildingHelper:AddBuilding(farm)
		farm:SetOwner(owner)
		farm:UpdateHealth(buildTime, true, 1.0)
		farm:SetControllableByPlayer(ownerPlayerID, true)
		farm:RemoveModifierByName("modifier_invulnerable")
		--print("Attempting to add 'modifier_stun_lua' to the tower to stop it from firing before it's done being built")
		--print("Modifiers BEFORE adding stun modifier: " .. farm:GetModifierCount())
		farm:AddNewModifier(farm, nil, "modifier_stun_lua", {duration = -1})
		--print("Modifiers AFTER adding stun modifier: " .. farm:GetModifierCount())
		return true
	end
end

--rename to AddBuilding(keys)
function AddBuildingToPlayer(keys)
--@params
--keys.BuildingName - The name of the unit to be trained
--Called by OnChannelSucceeded
--Builds a tower or bank with BuildingHelper as specified by various abilities on the Peon/Master Peon.  All resource/interruption checking has been completed at this point.
--Double checks to make sure a player doesn't already have a bank (2 peons?)
--Returns: nothing	

	--build time for normal buildings set to 1s, build time for banks is changed below to 30s. This is the max that BuildingHelper will accept before scaling weird.
	--TODO: Find out why this is here, it doesn't seem needed
	BUILD_TIME=0.0

	-- get the player owner
	local owner = keys.caster:GetOwner() --handle
	-- print ("HWDEBUG:*** GetBuildingPoint: keys.caster info")
	-- print (keys.caster)
	-- print (keys.caster:GetUnitName())
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int
	-- get the players hero handle
	local ownerHero = owner:GetAssignedHero() --handle
	local goldCost = keys.GoldCost --int
	local foodCost = keys.FoodCost --int
	local woodCost = keys.WoodCost --int
	if woodCost == nil then
		--set the woodcost to nothing here so i dont have to set every single unit to a wood cost
		woodCost = 0
	end
	local buildingName = keys.BuildingName --string ""

	local playerGold = ownerHero:GetGold() --int

	local playerName = PlayerResource:GetPlayerName(ownerPlayerID)
	if playerName == "" then playerName = "PLAYER_NAME_BLANK-" .. ownerPlayerID end


	--perform a check there to see if we are building a bank and if the player already has a bank. If they do, do not allow another.
	if buildingName == "npc_dota_player_bank" then
		--print("HWDEBUG: Check to see if the player already has a bank...")
		for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
			if heroData.nPlayerID == ownerPlayerID then
				--our player id matches the vPlayerHeroData player id, so lets modify this entry
				--first check if we can consume the food
				--if our already consumed food plus the food cost of this item is greater than our max food return false
				if heroData.bHasBank then
					print("HWERROR: Player already has a bank, can't build two.")
					return
				end
			end
		end
	end

	-- proceed with construction
	--local farm = CreateUnitByName(buildingName, buildingPoint, false, nil, nil, keys.caster:GetTeam())

	--farm:SetHullRadius(64)

	--	THIS IS A NECESSARY MOD TO THE EXAMPLE TO MAKE IT ATTACKABLE


	-- if CUSTOM_TOWER_NAMES_NO_TS[buildingName] then
	-- 	print ("HWDEBUG: The NPC spawned was a tower, removing TS.")
	-- 	farm:RemoveModifierByName('modifier_tower_truesight_aura')
	-- end

	if CUSTOM_TOWER_NAMES[buildingName] then
		if buildingName ~= "npc_dota_tower_anti_invis" then
			--print ("HWDEBUG: The NPC spawned was a tower, removing TS.")
			farm:RemoveModifierByName('modifier_tower_truesight_aura')
		end
		--print ("HWDEBUG: The NPC spawned was a tower, giving player score for it.")
		-- update the playerdata to reflect ownership of the bank
		for i = 1,#HeroWarsGameMode.vPlayerHeroData do
			local heroData = HeroWarsGameMode.vPlayerHeroData[i]
			if heroData.nPlayerID == ownerPlayerID then
				heroData.nTowersBuilt = heroData.nTowersBuilt + 1
			end
		end
	end

	--if what we built was a bank, start a timer for the player earning her gold
	if buildingName == "npc_dota_player_bank" then
		--print("HWDEBUG: The building was a bank, trying to start a timer")
		-- *** BANK TIMER ***
		-- on a 30s delay (time to build the bank)
		-- announce to allow players playername has completed their bank.
		local uniqueTimerName = "bankTimer_" .. ownerPlayerID
		Timers:CreateTimer(uniqueTimerName, {
		useOldStyle = true,
		endTime = GameRules:GetGameTime() + BUILD_TIME,
		bHasBroadCast = false,
		callback = function()
			if not bHasBroadCast then
				--Broadcast a message to all players that so and so has completed their bank
				GameRules:SendCustomMessage("<font color='#0AC80E'> " .. playerName .. " has completed their bank.</font>", 0, 0)
				bHasBroadCast = true
			end

			--print ("HWDEBUG: Hello. I'm running after " .. BUILD_TIME .. " seconds and then every two seconds thereafter.")
			--add gold to the player
			--print ("HWDEBUG: This timer is named: " .. uniqueTimerName)
			ownerHero:ModifyGold( BANK_GOLD_INCREMENT, true, 0 )
			-- ownerHero:SetGold(ownerHero:GetGold() + BANK_GOLD_INCREMENT, true)
			return GameRules:GetGameTime() + 2
		end
		})
		-- update the playerdata to reflect ownership of the bank
		for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
			if heroData.nPlayerID == ownerPlayerID then
				heroData.bHasBank = true
			end
		end
	end

	--Remove the stun that's put on buildings while they are being built
	--print("Modifiers BEFORE removing stun modifier: " .. farm:GetModifierCount())
	farm:RemoveModifierByName("modifier_stun_lua")
	--print("Modifiers AFTER removing stun modifier: " .. farm:GetModifierCount())

	--EXTRA CRUFT TO BE CLEANED UP BELOW
	--ok set the owner in herowars.lua - now can I get the player from getting at the objects owner? We'll see in a few.
	--local ownerPlayerID = keys.caster:GetOwner():GetPlayerID() -- get the playerID from the owner
	--local ownerHero = keys.caster:GetOwner():GetAssignedHero() -- get the Hero from the owner (testing to see which handle it is)
	-- print("The owners PlayerID: " .. ownerPlayerID)
	-- print("The owners assigned hero's gold (to test if GetAssigned Hero returns the  CDOTA_BaseNPC_Hero type: " .. ownerHero:GetGold())





	--local point = BuildingHelper:AddBuildingToGrid(keys.target_points[1], 2.34, ownerHero) --2.34 is based on 150x150
	--local point = BuildingHelper:AddBuildingToGrid(keys.target_points[1], 2, keys.caster) --2.34 is based on 150x150
	-- if point ~= -1 then
	-- 	local farm = CreateUnitByName(buildingName, point, false, nil, nil, keys.caster:GetTeam())
	-- 	BuildingHelper:AddBuilding(farm)
	-- 	farm:SetOwner(owner)
	-- 	farm:UpdateHealth(BUILD_TIME,true,.85)
	-- 	--farm:SetHullRadius(64)
	-- 	farm:SetControllableByPlayer(ownerPlayerID, true)
	
	-- 	--	THIS IS A NECESSARY MOD TO THE EXAMPLE TO MAKE IT ATTACKABLE
	-- 	farm:RemoveModifierByName("modifier_invulnerable")


	-- 	-- if CUSTOM_TOWER_NAMES_NO_TS[buildingName] then
	-- 	-- 	print ("HWDEBUG: The NPC spawned was a tower, removing TS.")
	-- 	-- 	farm:RemoveModifierByName('modifier_tower_truesight_aura')
	-- 	-- end

	-- 	if CUSTOM_TOWER_NAMES[buildingName] then
	-- 		if buildingName ~= "npc_dota_tower_anti_invis" then
	-- 			print ("HWDEBUG: The NPC spawned was a tower, removing TS.")
	-- 			farm:RemoveModifierByName('modifier_tower_truesight_aura')
	-- 		end
	-- 		print ("HWDEBUG: The NPC spawned was a tower, giving player score for it.")
	-- 		-- update the playerdata to reflect ownership of the bank
	-- 		for i = 1,#HeroWarsGameMode.vPlayerHeroData do
	-- 			local heroData = HeroWarsGameMode.vPlayerHeroData[i]
	-- 			if heroData.nPlayerID == ownerPlayerID then
	-- 				heroData.nTowersBuilt = heroData.nTowersBuilt + 1
	-- 			end
	-- 		end
	-- 	end

	-- 	--if what we built was a bank, start a timer for the player earning her gold
	-- 	if buildingName == "npc_dota_player_bank" then
	-- 		print("HWDEBUG: The building was a bank, trying to start a timer")
	-- 		-- *** BANK TIMER ***
	-- 		-- on a 30s delay (time to build the bank)
	-- 		-- announce to allow players playername has completed their bank.
	-- 		local uniqueTimerName = "bankTimer_" .. ownerPlayerID
	-- 		Timers:CreateTimer(uniqueTimerName, {
	-- 		useOldStyle = true,
	-- 		endTime = GameRules:GetGameTime() + BUILD_TIME,
	-- 		bHasBroadCast = false,
	-- 		callback = function()
	-- 			if not bHasBroadCast then
	-- 				--Broadcast a message to all players that so and so has completed their bank
	-- 				GameRules:SendCustomMessage("<font color='#0AC80E'> " .. playerName .. " has completed their bank.</font>", 0, 0)
	-- 				bHasBroadCast = true
	-- 			end

	-- 			--print ("HWDEBUG: Hello. I'm running after " .. BUILD_TIME .. " seconds and then every two seconds thereafter.")
	-- 			--add gold to the player
	-- 			--print ("HWDEBUG: This timer is named: " .. uniqueTimerName)
	-- 			ownerHero:ModifyGold( BANK_GOLD_INCREMENT, true, 0 )
	-- 			-- ownerHero:SetGold(ownerHero:GetGold() + BANK_GOLD_INCREMENT, true)
	-- 			return GameRules:GetGameTime() + 2
	-- 		end
	-- 		})
	-- 		-- update the playerdata to reflect ownership of the bank
	-- 		for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
	-- 			if heroData.nPlayerID == ownerPlayerID then
	-- 				heroData.bHasBank = true
	-- 			end
	-- 		end
	-- 	end

	-- 	--ok set the owner in herowars.lua - now can I get the player from getting at the objects owner? We'll see in a few.
	-- 	local ownerPlayerID = keys.caster:GetOwner():GetPlayerID() -- get the playerID from the owner
	-- 	local ownerHero = keys.caster:GetOwner():GetAssignedHero() -- get the Hero from the owner (testing to see which handle it is)
	-- 	-- print("The owners PlayerID: " .. ownerPlayerID)
	-- 	-- print("The owners assigned hero's gold (to test if GetAssigned Hero returns the  CDOTA_BaseNPC_Hero type: " .. ownerHero:GetGold())
	-- else
	-- 	print ("HWDEBUG: Something in BuildingHelper failed. The point was -1.")
	-- end
end
	--[[
	disbandBuilding - disbands a building - removes from building grid using building helper RemoveBuilding()
	food is returned in onEntityKilled
	]]
	
function disbandBuilding(keys)
--@params
--keys - uses the keys.caster EntityIndex
--Disbands buildings built. Food return is done through herowars.lua in OnEntityKilled. This method removes if from the BuildingHelper grid and the map
--Returns: nothing

	local thisBuilding_EntIdx = keys.caster:GetEntityIndex()
	local thisBuilding = EntIndexToHScript(thisBuilding_EntIdx)
	local thisBuildingOwnerID = thisBuilding:GetOwner():GetPlayerID()
	--start checking the properties of thisBuilding to confirm its what i need for RemoveBuilding.. i think it is
	-- print(thisBuilding:GetOwner():GetAssignedHero())
	-- print(thisBuilding:GetOwner():GetPlayerID())
	print("HWDEBUG: Removing the building")
	thisBuilding:RemoveBuilding(true)
end

--[[
*** CREEP WAVE FUNCTIONS ***
]]

function UpgradeCreepWave(keys)
--@params
--keys
--Called by OnSpellStart
--Upgrades the creep wave up to 10 times. Announces to the all players this has been done.
--Returns: nothing	

	local owner = keys.caster:GetOwner() --handle
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int
	-- get the players hero handle
	local ownerHero = owner:GetAssignedHero() --handle
	-- store the cost of the ability
	local goldCost = keys.GoldCost --int
	local foodCost = keys.FoodCost --int
	local cooldown = keys.Cooldown --float
	-- store the player gold for less typing
	local playerGold = ownerHero:GetGold() --int

	--get the team, we need it
	local team = keys.caster:GetTeam() -- int?

	--[[
	Validation
	]]

	--Check if the team has the max upgraded creep wave level
	if team == 2 then
		--print ("RADIANT Creep Upgrade Attempt")
		--now check to see if upgrading this creep wave will cause us to exceed the upgrade limit
		if HeroWarsGameMode.radiantCreepLvl == HeroWarsGameMode.maxCreepUpgradeLvl then
			--we cant upgrade
			--print ("HWDEBUG: CANT UPGRADE - AT MAX LIMIT - need to broadcast this to team in chat likely")
			GameRules:SendCustomMessage("<font color='#FF0000'>Creeps are at max level, cannot upgrade!!</font>", 2, 0)
			return
		end
	elseif team == 3 then
	--print ("DIRE Creep Upgrade Attempt")
	--now check to see if upgrading this creep wave will cause us to exceed the upgrade limit
		if HeroWarsGameMode.direCreepLvl == HeroWarsGameMode.maxCreepUpgradeLvl then
			--we cant upgrade
			--print ("HWDEBUG: CANT UPGRADE - AT MAX LIMIT - need to broadcast this to team in chat likely")
			GameRules:SendCustomMessage("<font color='#FF0000'>Creeps are at max level, cannot upgrade!!</font>", 3, 0)
			return
		end
	else
		print ("HWERROR: WARNING: NO TEAM VALUE FOUND EXITING!")
	end

	--Check to see if the player has enough gold, and reset the cooldown if he doesn't (the cooldown fires regardless)
	if playerGold > goldCost then 
		ownerHero:SpendGold(goldCost, 5) --works but the API is bugged. Says expects 3 params, but only needs 2 since player id was the first it expected.
	else -- they dont have the money so just return?
		print("HWERROR: Not enough gold!!")
		keys.ability:EndCooldown()
		return
	end

	--[[
	Execution
	]]

	--Start the cooldown for all players on the team
	StartGlobalCooldown(team, 0, cooldown)
	-- if team == 2 then
	-- 	local prevEnt
	-- 	for i=1, #RADIANT_ARMORIES do 
	-- 		local buildingName = RADIANT_ARMORIES[i]
	-- 		local buildingEnt = Entities:FindByName(prevEnt, buildingName)
	-- 		local _ability = buildingEnt:GetAbilityByIndex(0)
	-- 		_ability:StartCooldown(cooldown)
	-- 	end
	-- elseif team == 3 then
	-- 	local prevEnt
	-- 	for i=1, #DIRE_ARMORIES do 
	-- 		local buildingName = DIRE_ARMORIES[i]
	-- 		local buildingEnt = Entities:FindByName(prevEnt, buildingName)
	-- 		local _ability = buildingEnt:GetAbilityByIndex(0)
	-- 		_ability:StartCooldown(cooldown)
	-- 	end
	-- else
	-- 	print ("HWERROR: WARNING: NO TEAM VALUE FOUND EXITING!")
	-- end

	--upgrade the wave for the appopriate team
	if team == 2 then
		print ("RADIANT Creep Upgrade")
		--upgrade the creep level
		HeroWarsGameMode.radiantCreepLvl = HeroWarsGameMode.radiantCreepLvl + 1
		GameRules:SendCustomMessage("<font color='#0000A0'>RADIANT have upgraded their creeps to level " .. HeroWarsGameMode.radiantCreepLvl .. "!!</font>", 0, 0)
		--GameRules:SendCustomMessage("<font color='#0000A0'>Your teams creep wave has been upgraded to level " .. HeroWarsGameMode.radiantCreepLvl .. "!!</font>", 2, 0)
	elseif team == 3 then
		print ("DIRE Creep Upgrade")
		--now check to see if upgrading this creep wave will cause us to exceed the upgrade limit
		--upgrade the creep level
		HeroWarsGameMode.direCreepLvl = HeroWarsGameMode.direCreepLvl + 1
		GameRules:SendCustomMessage("<font color='#0000A0'>DIRE have upgraded their creeps to level " .. HeroWarsGameMode.direCreepLvl .. "!!</font>", 0, 0)
		--GameRules:SendCustomMessage("<font color='#0000A0'>Your teams creep wave has been upgraded to level " .. HeroWarsGameMode.direCreepLvl .. "!!</font>", 3, 0)
	end
end

function SpawnSpecialCreepWave(keys)
--@params
--keys.UnitType - The type of special wave to be spawned
--Called by OnChannelSucceeded
--Summons a wave of additional creeps to go with the base wave. All resource/interruption checking has been completed.
--Upgraded waves based on rounds are controlled here as is controlling the cooldown and upgrading of the archer waves.
--** The cost of Archer Reinforcements and Archer Assassins is handled here, unlike Windigo/Hydras **
--Returns: nothing	

	local owner = keys.caster:GetOwner() --handle
	-- get the playerID from the owner
	local ownerPlayerID = owner:GetPlayerID() --int
	-- get the players hero handle
	local ownerHero = owner:GetAssignedHero() --handle
	-- store the cost of the ability
	local goldCost = keys.GoldCost --int
	local unitType = keys.UnitType --string ""
	-- store the player gold for less typing
	local playerGold = ownerHero:GetGold() --int
	local cooldown = keys.Cooldown --float
	--print("HWDEBUG: Cooldown = " .. cooldown)
	--get the team, we need it
	local team = keys.caster:GetTeam() -- int?
	--print ("HWDEBUG: *** SPAWNSPECIALWAVE BUTTON PRESSED ***")
	--print ("HWDEBUG: goldCost = " .. goldCost)
	--print ("HWDEBUG: unitType = " .. unitType)

	--[[
	Support for multiple unit/wave summons from the same button depending on round.
	]]
	--print("Round Number = " .. HeroWarsGameMode.nRoundNumber)
	--windigo/windigo brat/hydralisk all the same button
	if unitType == "npc_dota_wave_windigo" then
		if HeroWarsGameMode.nRoundNumber == 3 then
			unitType = "npc_dota_wave_windigo_brat"
			goldCost = keys.lvltwo_GoldCost
		elseif HeroWarsGameMode.nRoundNumber == 4 then
			unitType = "npc_dota_wave_hydralisk"
			goldCost = keys.lvlthree_GoldCost
		end
	end

	--Automatically adjust the creep waves for archer reinforcements to be the proper UnitType
	if unitType == "npc_dota_wave_archer_reinforcements_lvlone" then
		if HeroWarsGameMode.nRoundNumber >= 2 and HeroWarsGameMode.nRoundNumber <= 3 then
			unitType = "npc_dota_wave_archer_reinforcements_lvltwo"
		elseif HeroWarsGameMode.nRoundNumber > 3 then
			unitType = "npc_dota_wave_archer_reinforcements_lvlthree"
		end
	end

	--Automatically adjust the creep waves for archer assassins to be the proper UnitType
	if unitType == "npc_dota_wave_archer_assassins_lvlone" then
		if HeroWarsGameMode.nRoundNumber >= 2 and HeroWarsGameMode.nRoundNumber <= 3 then
			unitType = "npc_dota_wave_archer_assassins_lvltwo"
		elseif HeroWarsGameMode.nRoundNumber > 3 then
			unitType = "npc_dota_wave_archer_assassins_lvlthree"
		end
	end

	-- ^ need a matching block for archer assassins

	--Handle cooldowns and gold cost of both archers
	--We only need this check here now to deal with waves that dont require channel (archers and archer assassins)
	if unitType == "npc_dota_wave_archer_reinforcements_lvlone" or unitType == "npc_dota_wave_archer_reinforcements_lvltwo" or unitType == "npc_dota_wave_archer_reinforcements_lvlthree" or unitType == "npc_dota_wave_archer_assassins_lvlone" or unitType == "npc_dota_wave_archer_assassins_lvltwo" or unitType == "npc_dota_wave_archer_assassins_lvlthree" then
		if playerGold > goldCost then 
			ownerHero:SpendGold(goldCost, 5)
		else 
			print("HWERROR: Not enough gold!!")
			keys.ability:EndCooldown()
			return
		end
		local abilityIndex = keys.ability:GetAbilityIndex()
		StartGlobalCooldown(team, abilityIndex, cooldown)
	end

	--Spawn the Units!!
	HeroWarsGameMode:SpawnSpecialWaveUnits(unitType, team)
end

--[[
	*** UTILITY ***
]]

function StartGlobalCooldown(team, abiIdx, cooldown)
--Starts a global cooldown on an ability for a team
--Called by various
--@params
--team - The team for which the global cooldown should be fired
--abiIdx - The ability index of the ability
--cooldown - The cooldown
--Returns: nothing	
	if team == 2 then
		local prevEnt
		for i=1, #RADIANT_ARMORIES do 
			local buildingName = RADIANT_ARMORIES[i]
			local buildingEnt = Entities:FindByName(prevEnt, buildingName)
			local _ability = buildingEnt:GetAbilityByIndex(abiIdx)
			_ability:StartCooldown(cooldown)
		end
	elseif team == 3 then
		local prevEnt
		for i=1, #DIRE_ARMORIES do 
			local buildingName = DIRE_ARMORIES[i]
			local buildingEnt = Entities:FindByName(prevEnt, buildingName)
			local _ability = buildingEnt:GetAbilityByIndex(abiIdx)
			_ability:StartCooldown(cooldown)
		end
	else
		print ("HWERROR: WARNING: NO TEAM VALUE FOUND EXITING!")
	end
end
