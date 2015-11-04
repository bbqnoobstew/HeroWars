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
Hero Wars!
Original Author (of the Dota 2 version) - bbqnoobstew (njg) 
- started 2014/08/23
- last updated 2015/02/08
About 75 percent complete.
CURRENT MAP VERSION - v085
CURRENT CODE VERSION - v086
v086 - 2015/07/03
	Commented a few more methods/lines
	Changing some of the HWDEBUG messages to [HERO WARS]. The HWDEBUG messages that remain are there for debugging.
	Some housekeeping. Lots more to do.
v085 - 2015/02/08
	All major issues resolved. Needs testing.

]]


require( "utils/buildinghelper")
print ("[HERO WARS] *** Hero Wars Started *** herowars.lua loaded")

--[[
Utility Methods
]]

function InDireRectA(Px, Py)
-- InDireRectA - Utility function that determines if a point is inside a given rectangle (Dire Rectangle A).
-- Params: Px - the X of our point to check.
-- Params: Py - the Y of our point to check.
-- Returns: true of the point is in the rect, false if not.
	local AxMax = 3200
	local AxMin = -7296
	local AyMax = 5312
	local AyMin = 1280


	if Px >= AxMin then
		PxMinInRange = true
		else PxMinInRange = false
	end
	if Px <= AxMax then
		PxMaxInRange = true
		else PxMaxInRange = false
	end
	if Py >= AyMin then -- for Dire Rect B must be > not >= b/c they have to be over the line not on it.
		PyMinInRange = true
		else PyMinInRange = false
	end
	if Py <= AyMax then
		PyMaxInRange = true -- for Randiant Rect B must be < not <=  b/c they have to be over the line not on it.
		else PyMaxInRange = false
	end

	--all of them must be true for this to continue.
	if PxMinInRange and PxMaxInRange and PyMinInRange and PyMaxInRange then
		--they are all true
		--print ("In range")
		return true
		else
			--at least one is false
			return false
			--print ("Not in range")
	end
end

function InDireRectB(Px, Py)
-- InDireRectA - Utility function that determines if a point is inside a given rectangle (Dire Rectangle A).
-- Params: Px - the X of our point to check.
-- Params: Py - the Y of our point to check.
-- Returns: true of the point is in the rect, false if not.
	local AxMax = 6976
	local AxMin = 3200
	local AyMax = 5312
	local AyMin = 0


	if Px >= AxMin then
		PxMinInRange = true
		else PxMinInRange = false
	end
	if Px <= AxMax then
		PxMaxInRange = true
		else PxMaxInRange = false
	end
	if Py > AyMin then -- for Dire Rect B must be > not >= b/c they have to be over the line not on it.
		PyMinInRange = true
		else PyMinInRange = false
	end
	if Py <= AyMax then -- for Randiant Rect B must be < not <=  b/c they have to be over the line not on it.
		PyMaxInRange = true
		else PyMaxInRange = false
	end

	--all of them must be true for this to continue.
	if PxMinInRange and PxMaxInRange and PyMinInRange and PyMaxInRange then
		--they are all true
		--print ("In range")
		return true
		else
			--at least one is false
			return false
			--print ("Not in range")
	end
end

function InRadiantRectA(Px, Py)
-- InDireRectA - Utility function that determines if a point is inside a given rectangle (Dire Rectangle A).
-- Params: Px - the X of our point to check.
-- Params: Py - the Y of our point to check.
-- Returns: true of the point is in the rect, false if not.
	local AxMax = 3200
	local AxMin = -7296
	local AyMax = -1280
	local AyMin = -5312


	if Px >= AxMin then
		PxMinInRange = true
		else PxMinInRange = false
	end
	if Px <= AxMax then
		PxMaxInRange = true
		else PxMaxInRange = false
	end
	if Py >= AyMin then -- for Dire Rect B must be > not >= b/c they have to be over the line not on it.
		PyMinInRange = true
		else PyMinInRange = false
	end
	if Py <= AyMax then -- for Randiant Rect B must be < not <=  b/c they have to be over the line not on it.
		PyMaxInRange = true
		else PyMaxInRange = false
	end

	--all of them must be true for this to continue.
	if PxMinInRange and PxMaxInRange and PyMinInRange and PyMaxInRange then
		--they are all true
		--print ("In range")
		return true
		else
			--at least one is false
			return false
			--print ("Not in range")
	end
end

function InRadiantRectB(Px, Py)
-- InDireRectA - Utility function that determines if a point is inside a given rectangle (Dire Rectangle A).
-- Params: Px - the X of our point to check.
-- Params: Py - the Y of our point to check.
-- Returns: true of the point is in the rect, false if not.
	local AxMax = 6976
	local AxMin = 3200
	local AyMax = 0
	local AyMin = -5312


	if Px >= AxMin then
		PxMinInRange = true
		else PxMinInRange = false
	end
	if Px <= AxMax then
		PxMaxInRange = true
		else PxMaxInRange = false
	end
	if Py >= AyMin then -- for Dire Rect B must be > not >= b/c they have to be over the line not on it.
		PyMinInRange = true
		else PyMinInRange = false
	end
	if Py < AyMax then -- for Randiant Rect B must be < not <=  b/c they have to be over the line not on it.
		PyMaxInRange = true
		else PyMaxInRange = false
	end

	--all of them must be true for this to continue.
	if PxMinInRange and PxMaxInRange and PyMinInRange and PyMaxInRange then
		--they are all true
		--print ("In range")
		return true
		else
			--at least one is false
			return false
			--print ("Not in range")
	end
end


function Set (list)
-- Set - Use this function to make a table's values accessible by string. i.e. 'elseif CUSTOM_TOWER_NAMES[killedUnitName] then' where killed unit name is a string and we are checking to see if that value exists in the table
-- Params: list - a list of values to be put in to a set
-- Returns: a 'set' of values
	local set = {}
	for _, l in ipairs(list) do set[l] = true end
	return set
end



--[[
** CONSTANTS **
]]

--each of the buildings that each player will be assigned
radiantPlayer1Buildings = {"Radiant_Brooder_Player1", "Radiant_Armory_Player1", "Radiant_Barracks_Player1"}
radiantPlayer2Buildings = {"Radiant_Brooder_Player2", "Radiant_Armory_Player2", "Radiant_Barracks_Player2"}
radiantPlayer3Buildings = {"Radiant_Brooder_Player3", "Radiant_Armory_Player3", "Radiant_Barracks_Player3"}
radiantPlayer4Buildings = {"Radiant_Brooder_Player4", "Radiant_Armory_Player4", "Radiant_Barracks_Player4"}
radiantPlayer5Buildings = {"Radiant_Brooder_Player5", "Radiant_Armory_Player5", "Radiant_Barracks_Player5"}

direPlayer1Buildings = {"Dire_Brooder_Player1", "Dire_Armory_Player1", "Dire_Barracks_Player1"}
direPlayer2Buildings = {"Dire_Brooder_Player2", "Dire_Armory_Player2", "Dire_Barracks_Player2"}
direPlayer3Buildings = {"Dire_Brooder_Player3", "Dire_Armory_Player3", "Dire_Barracks_Player3"}
direPlayer4Buildings = {"Dire_Brooder_Player4", "Dire_Armory_Player4", "Dire_Barracks_Player4"}
direPlayer5Buildings = {"Dire_Brooder_Player5", "Dire_Armory_Player5", "Dire_Barracks_Player5"}

--The list of armories for each team, so I can enable a global gooldown for upgrading the creep wave and summoning archers.
RADIANT_ARMORIES = {"Radiant_Armory_Player1", "Radiant_Armory_Player2", "Radiant_Armory_Player3", "Radiant_Armory_Player4", "Radiant_Armory_Player5"}
DIRE_ARMORIES = {"Dire_Armory_Player1", "Dire_Armory_Player2", "Dire_Armory_Player3", "Dire_Armory_Player4", "Dire_Armory_Player5"}

--list of towers to remove true sight from
TOWERS_REMOVE_TS = {"tower_radiant_tp_watchtowerlvl2_1", "tower_radiant_tp_watchtowerlvl2_2", "tower_radiant_tp_cannonlvl2", "tower_dire_tp_watchtowerlvl2_1", "tower_dire_tp_watchtowerlvl2_2", "tower_dire_tp_cannonlvl2", "tower_dire_row1_watchtowerlvl2_1", "tower_dire_row1_watchtowerlvl2_2", "tower_dire_row1_watchtowerlvl2_3", "tower_dire_row1_watchtowerlvl2_4", "tower_dire_row1_cannonlvl2", "tower_radiant_row1_watchtowerlvl2_1", "tower_radiant_row1_watchtowerlvl2_2", "tower_radiant_row1_watchtowerlvl2_3", "tower_radiant_row1_watchtowerlvl2_4", "tower_radiant_row1_cannonlvl2", "tower_radiant_row2_cannonlvl2_1", "tower_radiant_row2_cannonlvl2_2", "tower_radiant_row2_watchtowerlvl3_1", "tower_radiant_row2_watchtowerlvl3_2", "tower_radiant_row2_watchtowerlvl3_3", "tower_radiant_row2_watchtowerlvl3_4", "tower_dire_row2_watchtowerlvl3_1", "tower_dire_row2_watchtowerlvl3_2", "tower_dire_row2_watchtowerlvl3_3", "tower_dire_row2_watchtowerlvl3_4", "tower_dire_row2_cannonlvl2_1", "tower_dire_row2_cannonlvl2_2", "tower_dire_row3_snowcone_1", "tower_dire_row3_snowcone_2", "tower_dire_row3_bloodumpster_1", "tower_dire_row3_bloodumpster_2", "tower_dire_row3_bloodumpster_3", "tower_dire_row3_bloodumpster_4", "tower_radiant_row3_snowcone_1", "tower_radiant_row3_snowcone_2", "tower_radiant_row3_bloodumpster_1", "tower_radiant_row3_bloodumpster_2", "tower_radiant_row3_bloodumpster_3", "tower_radiant_row3_bloodumpster_4", "tower_dire_base_destro_1", "tower_dire_base_destro_2", "tower_dire_base_destro_3", "tower_dire_base_destro_4", "tower_radiant_base_destro_1", "tower_radiant_base_destro_2", "tower_radiant_base_destro_3", "tower_radiant_base_destro_4", "farm_dire", "farm_radiant"}
--DO NOT ADD THIS TOWER TO TS LIST - npc_dota_tower_anti_invis
-- here are the actual names that i've not included: tower_radiant_row3_antiinvis, tower_dire_row3_antiinvis

--tower list for tracking tower kills and maybe later builds
CUSTOM_TOWER_NAMES = Set {"npc_dota_tower_watch_tower_lvlone", "npc_dota_tower_watch_tower_lvltwo", "npc_dota_tower_watch_tower_lvlthree", "npc_dota_tower_watch_tower_lvlfour", "npc_dota_tower_cannon_tower_lvlone", "npc_dota_tower_cannon_tower_lvltwo", "npc_dota_tower_cannon_tower_lvlfour", "npc_dota_tower_anti_invis", "npc_dota_tower_blood_dumpster", "npc_dota_tower_snowcone_maker", "npc_dota_tower_destroyer", "npc_dota_tower_slower", "npc_dota_tower_longrange", "npc_dota_tower_advlongrange"}
CUSTOM_TOWER_NAMES_NO_TS = Set {"npc_dota_tower_watch_tower_lvlone", "npc_dota_tower_watch_tower_lvltwo", "npc_dota_tower_watch_tower_lvlthree", "npc_dota_tower_watch_tower_lvlfour", "npc_dota_tower_cannon_tower_lvlone", "npc_dota_tower_cannon_tower_lvltwo", "npc_dota_tower_cannon_tower_lvlfour", "npc_dota_tower_blood_dumpster", "npc_dota_tower_snowcone_maker", "npc_dota_tower_destroyer", "npc_dota_tower_slower", "npc_dota_tower_longrange", "npc_dota_tower_advlongrange"}

--used by custom_abilities.lua to check if the player is attempting to place a building
BUILDABLE_BUILDINGS = Set {"npc_dota_player_bank", "npc_dota_tower_watch_tower_lvlone", "npc_dota_tower_watch_tower_lvltwo", "npc_dota_tower_watch_tower_lvlthree", "npc_dota_tower_watch_tower_lvlfour", "npc_dota_tower_cannon_tower_lvlone", "npc_dota_tower_cannon_tower_lvltwo", "npc_dota_tower_cannon_tower_lvlfour", "npc_dota_tower_anti_invis", "npc_dota_tower_blood_dumpster", "npc_dota_tower_snowcone_maker", "npc_dota_tower_destroyer", "npc_dota_tower_slower", "npc_dota_tower_longrange", "npc_dota_tower_advlongrange"}

--units and buildings that refund food to the player if killed or disbanded. If updating, also update the table in self:_SetInitialValues
FOOD_REFUND_UNITS = Set {"npc_dota_player_bank", "npc_dota_tower_watch_tower_lvlone", "npc_dota_tower_watch_tower_lvlfour", "npc_dota_tower_cannon_tower_lvlfour", "npc_dota_tower_anti_invis", "npc_dota_tower_snowcone_maker", "npc_dota_tower_destroyer", "npc_dota_tower_slower", "npc_dota_tower_longrange", "npc_dota_tower_advlongrange"}

--the following is used to add everything to BuildingHelpers grid
ALL_LANE_BUILDINGS = {"tower_radiant_tp_watchtowerlvl2_1", "tower_radiant_tp_watchtowerlvl2_2", "tower_radiant_tp_cannonlvl2", "tower_dire_tp_watchtowerlvl2_1", "tower_dire_tp_watchtowerlvl2_2", "tower_dire_tp_cannonlvl2", "dire_base_builder_blocker", "radiant_base_builder_blocker", "tower_dire_row1_watchtowerlvl2_1", "tower_dire_row1_watchtowerlvl2_2", "tower_dire_row1_watchtowerlvl2_3", "tower_dire_row1_watchtowerlvl2_4", "tower_dire_row1_cannonlvl2", "tower_radiant_row1_watchtowerlvl2_1", "tower_radiant_row1_watchtowerlvl2_2", "tower_radiant_row1_watchtowerlvl2_3", "tower_radiant_row1_watchtowerlvl2_4", "tower_radiant_row1_cannonlvl2", "tower_radiant_row2_cannonlvl2_1", "tower_radiant_row2_cannonlvl2_2", "tower_radiant_row2_watchtowerlvl3_1", "tower_radiant_row2_watchtowerlvl3_2", "tower_radiant_row2_watchtowerlvl3_3", "tower_radiant_row2_watchtowerlvl3_4", "tower_dire_row2_watchtowerlvl3_1", "tower_dire_row2_watchtowerlvl3_2", "tower_dire_row2_watchtowerlvl3_3", "tower_dire_row2_watchtowerlvl3_4", "tower_dire_row2_cannonlvl2_1", "tower_dire_row2_cannonlvl2_2", "tower_dire_row3_snowcone_1", "tower_dire_row3_snowcone_2", "tower_dire_row3_bloodumpster_1", "tower_dire_row3_bloodumpster_2", "tower_dire_row3_bloodumpster_3", "tower_dire_row3_bloodumpster_4", "tower_radiant_row3_snowcone_1", "tower_radiant_row3_snowcone_2", "tower_radiant_row3_bloodumpster_1", "tower_radiant_row3_bloodumpster_2", "tower_radiant_row3_bloodumpster_3", "tower_radiant_row3_bloodumpster_4", "tower_dire_base_destro_1", "tower_dire_base_destro_2", "tower_dire_base_destro_3", "tower_dire_base_destro_4", "tower_radiant_base_destro_1", "tower_radiant_base_destro_2", "tower_radiant_base_destro_3", "tower_radiant_base_destro_4", "farm_dire", "farm_radiant", "tower_radiant_row3_antiinvis", "tower_dire_row3_antiinvis", "tower_radiant_base_antiinvis", "tower_dire_base_antiinvis"}

--the list of possible creeps - used for adding score/gold in OnEntityKilled
ALL_CREEPS = Set {"npc_dota_creep_dire_lvlone", "npc_dota_creep_dire_lvltwo", "npc_dota_creep_dire_lvlthree", "npc_dota_creep_dire_lvlfour", "npc_dota_creep_dire_lvlfive", "npc_dota_creep_dire_lvlsix", "npc_dota_creep_dire_lvlseven", "npc_dota_creep_dire_lvleight", "npc_dota_creep_dire_lvlnine", "npc_dota_creep_dire_lvlten", "npc_dota_creep_radiant_lvlone", "npc_dota_creep_radiant_lvltwo", "npc_dota_creep_radiant_lvlthree", "npc_dota_creep_radiant_lvlfour", "npc_dota_creep_radiant_lvlfive", "npc_dota_creep_radiant_lvlsix", "npc_dota_creep_radiant_lvlseven", "npc_dota_creep_radiant_lvleight", "npc_dota_creep_radiant_lvlnine", "npc_dota_creep_radiant_lvlten"}

--buildings that should have invulnerabilty applied to them
BUILDINGS_ADD_INVULN = {"radiant_fountain", "dire_fountain", "radiant_base_builder_blocker", "dire_base_builder_blocker"}

-- ** ADJUSTING BUILDING HELPER GRID SIZES AT STARTUP
BASE_BUILDING_BLOCKERS = Set {"radiant_base_builder_blocker", "dire_base_builder_blocker"} --set to size 40 to block building in the base

--the radiant/dire farms (the thing that needs to be killed for gg)
FARM_BUILDINGS = Set {"farm_dire", "farm_radiant"}

--radiant creep spawn location and also the radiant starting waypoint
RADIANT_SPAWN_LOCATION_NAME = "Radiant_CreepWaveSpawner" -- the name of the npc_dota_scripted_spawner entity - "Radiant_CreepWaveSpawner"
RADIANT_START_WAYPOINT_NAME = "wp_radiant_1"
DIRE_SPAWN_LOCATION_NAME = "Dire_CreepWaveSpawner"
DIRE_START_WAYPOINT_NAME = "wp_dire_1"

--all the base lane creeps
DIRE_BASE_WAVE_CREEPS = {"npc_dota_creep_dire_lvlone", "npc_dota_creep_dire_lvltwo", "npc_dota_creep_dire_lvlthree", "npc_dota_creep_dire_lvlfour", "npc_dota_creep_dire_lvlfive", "npc_dota_creep_dire_lvlsix", "npc_dota_creep_dire_lvlseven", "npc_dota_creep_dire_lvleight", "npc_dota_creep_dire_lvlnine", "npc_dota_creep_dire_lvlten"}
RADIANT_BASE_WAVE_CREEPS = {"npc_dota_creep_radiant_lvlone", "npc_dota_creep_radiant_lvltwo", "npc_dota_creep_radiant_lvlthree", "npc_dota_creep_radiant_lvlfour", "npc_dota_creep_radiant_lvlfive", "npc_dota_creep_radiant_lvlsix", "npc_dota_creep_radiant_lvlseven", "npc_dota_creep_radiant_lvleight", "npc_dota_creep_radiant_lvlnine", "npc_dota_creep_radiant_lvlten"}


-- *** RULES STUFF ***

-- this is used in custom_abilities.lua where the bank timer is started.
BANK_GOLD_INCREMENT = 6

--hero kill bonus
BASE_KILL_BONUS = 200

--init this variables to zero - this was for counting the number of round 4 creeps b/c I thought it was bugged... it's not
radiantRoundFourSpawnCount = 0
direRoundFourSpawnCount = 0

-- DEBUG --
--set this to true to get more gold and shorter rounds
debugMode = false

if debugMode then 
	ROUND_TIME = 60.0
	PLAYER_STARTING_GOLD = 5000
	DUEL_INTERVAL = 30
else
	ROUND_TIME = 780.0
	PLAYER_STARTING_GOLD = 0
	DUEL_INTERVAL = 300
end

--Create a "class" for our game mode. This works inside the dota2 lua interpreter but not in a standalone. See notes below for more detailed information.
if HeroWarsGameMode == nil then
	print ( '[HERO WARS] Creating HeroWarsGameMode game mode' )
	--HeroWarsGameMode = {}
	HeroWarsGameMode = class({})
	HeroWarsGameMode.szEntityClassName = "herowars"
    HeroWarsGameMode.szNativeClassName = "dota_base_game_mode"
    HeroWarsGameMode.__index = HeroWarsGameMode
end

--[[
Detailed notes on the above code (expand):
	The table that gets created:
	table: 0x033b0b30

	Before assingment of axEntity stuff
	{
	   __class__                       	= table: 0x033b0b30 (table, already seen) (note this is the same table that contains this table. tableception.)
	   __getbase__                     	= function: 0x033b0ff0 (function)
	   __getclass__                    	= function: 0x033b0b58 (function)
	   __initprops__                   	= table: 0x033b0f40 (table)
	   {
	   }
	   __instanceof__                  	= function: 0x033b0f68 (function)
	}

	After assignment
	{
	   __class__                       	= table: 0x033b0b30 (table, already seen)
	   __getbase__                     	= function: 0x033b0ff0 (function)
	   __getclass__                    	= function: 0x033b0b58 (function)
	   __initprops__                   	= table: 0x033b0f40 (table)
	   {
	   }
	   __instanceof__                  	= function: 0x033b0f68 (function)
	   __index                         	= table: 0x033b0b30 (table, already seen)
	   szEntityClassName               	= "herowars" (string)
	   szNativeClassName               	= "dota_base_game_mode" (string)
	}
]]

function HeroWarsGameMode:_SetInitialValues()
--@params
--none
--Called by InitGameMode
--set the initial values for the class. My 'init'. Also does building to food mapping and sets the parameters for the first thinker
--Returns: Nothing



	--set the initial 'self' class variables
	self.nRoundNumber = 1

	--table to hold each hero and their values/scores/etc
	self.vPlayerHeroData = {}

	--number of players on each team
	self.nDirePlayers = 0
	self.nRadiantPlayers = 0

	--the gold per kill each member of the teams will earn
	self.nRadiantGPK = 0
	self.nDireGPK = 0

	--are we in a duel?
	self.inDuel = false

	--has the game start?
	self.gameStarted = false

	--set the interval between duels
	self.duelInterval = DUEL_INTERVAL
	
	--have we prepared for lift off?
	self.PreGameSetupComplete = false

	-- creep spawn
	self.radiantCreepLvl = 1
	self.direCreepLvl = 1
	self.maxCreepUpgradeLvl = 10

	--dynamic building assignment neat!
	self.RadiantPlayerSlot = 0
	self.DirePlayerSlot = 0

	--legacy way of keeping time
	self.inRoundTime = 0
	self.timeBetweenDuels = 0

	--[[
		*** BUILDING TO FOOD MAPPING ***
		Use case - later when a unit dies or is disbanded we can return the food to the player getting the amount directly by passing in the unit name.
	]]

	buildingFoodValues = {}
	buildingFoodValues["npc_dota_unit_peon"] = 1
	buildingFoodValues["npc_dota_unit_master_peon"] = 1
	buildingFoodValues["npc_dota_player_bank"] = 10
	buildingFoodValues["npc_dota_tower_watch_tower_lvlone"] = 1
	buildingFoodValues["npc_dota_tower_watch_tower_lvlfour"] = 1
	buildingFoodValues["npc_dota_tower_cannon_tower_lvlfour"] = 1
	buildingFoodValues["npc_dota_tower_anti_invis"] = 2
	buildingFoodValues["npc_dota_tower_snowcone_maker"] = 2
	buildingFoodValues["npc_dota_tower_destroyer"] = 3
	buildingFoodValues["npc_dota_tower_slower"] = 3
	buildingFoodValues["npc_dota_tower_longrange"] = 2
	buildingFoodValues["npc_dota_tower_advlongrange"] = 2

	--Set the parameters for when thinking starts so that the first think state is _thinkState_Prep
	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_Prep' )

end

function HeroWarsGameMode:InitGameMode()
--@params
--none
--Called from C++ to Initialize
--Initialize Hero Wars. Set up the console variables, set the initial values, set some rules and set the think context
--Returns: Nothing

	HeroWarsGameMode = self

	--bind console commands
	local function _boundHWConsoleCommand(...)
		return self:_HWConsoleCommand(...)
	end
	Convars:RegisterCommand( "herowars_status", _boundHWConsoleCommand, "Report the status of HeroWars", 0 )

	-- local function _boundEntityConsoleCommand(...)
	-- 	return self:__EntityConsoleCommand(...)
	-- end
	-- Convars:RegisterCommand( "herowars_entities_list", _boundEntityConsoleCommand, "Attempt to iterate all the Entities", 0 )

	local function _boundDebugConsoleCommand(...)
		return self:_DebugConsoleCommand(...)
	end

	Convars:RegisterCommand( "herowars_test", _boundDebugConsoleCommand, "For debugging and testing", 0 )

	-- Convars:RegisterCommand( "buildings", Dynamic_Wrap(HeroWarsGameMode, 'DisplayBuildingGrids'), "blah", 0 )

	-- Convars:RegisterCommand( "herowars_ent_test", Dynamic_Wrap(HeroWarsGameMode, '_EntityIdentifying'), nil, 0 )
	--Convars:RegisterCommand( "herowars_score", Dynamic_Wrap(HeroWarsGameMode, '_HWConsoleScore'), nil, 0 )

	local function _boundHWConsoleScore(...)
		return self:_HWConsoleScore(...)
	end
	Convars:RegisterCommand( "herowars_score", _boundHWConsoleScore, "Display the current score", 0 )


	-- test getting the map length
	worldMaxX = GetWorldMaxX() 
	worldMinX = GetWorldMinX()
	nMapLength = worldMaxX - worldMinX
	
	--call the setting of the initial values?
	--when do we return?
	print ("[HWDEBUG]: Setting Initial Values")
	self:_SetInitialValues()

	--set the initial game rules. GameRules being a dota2 api call
	print ("[HWDEBUG]: Setting the game rules")
	--GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 20.0 )
	GameRules:SetPreGameTime( 20.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTimeOfDay( 0.5 )

	--gold per tick = 0 b/c gold is earned per creep kill
	GameRules:SetGoldPerTick( 0 )

	--going to leave this off for now... do some play testing I like the built in bounty system
	GameRules:SetUseBaseGoldBountyOnHeroes ( true )

	--set respawning to false so I can control it
	GameRules:SetHeroRespawnEnabled( false )

	--Set the custom game set up time (allow for picking teams)
	--doesn't work...
	--GameRules:SetCustomGameSetupTimeout( 60 ) -- set the custom game setup phase to last 60 seconds, set to 0 skip the custom game setup, or -1 to disable the timeout
	
	--Set the time before auto launch
	GameRules:SetCustomGameSetupAutoLaunchDelay ( 42 )

	--listen for the player to fully connect, then set up game rules inside OnPlayerLoaded
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(HeroWarsGameMode, 'onPlayerLoaded'), self)
	--listen for the npc's to spawn - ultimately filtering out for heros to populate the hero data table
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(HeroWarsGameMode, 'OnNPCSpawned'), self)
	--listen for entities to die so I can see if the peon or players towers die to refund them the food
 	ListenToGameEvent('entity_killed', Dynamic_Wrap(HeroWarsGameMode, 'OnEntityKilled'), self)
 	--listen for the game event of players talking so i can allow chat commands
 	--    player_chat [broken]: a public player chat - broken according to api docs - move on
 	--ListenToGameEvent('player_chat', Dynamic_Wrap(HeroWarsGameMode, 'OnPlayerChat'), self)
	--~ ListenToGameEvent( "dota_item_picked_up", Dynamic_Wrap( HeroWarsGameMode, 'OnItemPickedUp' ), self )
	--~ ListenToGameEvent( "dota_match_done", Dynamic_Wrap( HeroWarsGameMode, 'OnMatchDone' ), self )
	--~ ListenToGameEvent( "dota_holdout_revive_complete", Dynamic_Wrap( HeroWarsGameMode, 'OnHoldoutReviveComplete' ), self )

	--attempting to create my own modifier to stun. For use with towers and duels.
    LinkLuaModifier( "modifier_stun_lua", LUA_MODIFIER_MOTION_NONE )

	print "[HWDEBUG]: Starting first think"
	Entities:First():SetContextThink("HWThink", HeroWarsGameMode.Think, 0.25)
end



function HeroWarsGameMode:_SetupCustomBuildings()
--@params
--none
--Called from PreGameSetup
--Setup all the custom buildings. Add/remove invuln and truesight. Also add to buildinghelper grid.
--Returns: Nothing

	--print ("HWDEBUG: Setting up custom buildings...")
	-- ** DEBUG ** Attach the playersinfo debug method
	--self:_debugPlayersInfo()
		--4 - FindAllByName - Radiant_Town_Hall
	--the name of the unit in hammer. Also the shop search returns key's value

	 -- Remove building invulnerability
	 --TODO: FIX THIS SO NOT ALL THINGS ARE VULNERABLE - ONLY TOWERS

	 --make the fogs invulnerable :)
	local prevEnt
	for i=1, #BUILDINGS_ADD_INVULN do 
		local buildingName = BUILDINGS_ADD_INVULN[i]
		--print ("Building Name = " .. buildingName)
		local buildingEnt = Entities:FindByName(prevEnt, buildingName)
		--buildingEnt:AddModifierByName('modifier_invulnerable')
		buildingEnt:AddNewModifier(nil, nil, 'modifier_invulnerable' ,nil)

	end

    --print("HWDEBUG: Make buildings vulnerable")
    local allBuildings = Entities:FindAllByClassname('npc_dota_building')
    for i = 1, #allBuildings, 1 do
        local building = allBuildings[i]
        if building:HasModifier('modifier_invulnerable') then
            building:RemoveModifierByName('modifier_invulnerable')
        end
    end

	--remove truesight from the towers that shouldn't have it.
	local prevEnt
	for i=1, #TOWERS_REMOVE_TS do 
		local towerName = TOWERS_REMOVE_TS[i]
		towerEnt = Entities:FindByName(prevEnt, towerName)
		if towerEnt:HasModifier('modifier_tower_truesight_aura') then
			towerEnt:RemoveModifierByName('modifier_tower_truesight_aura')
		end
	end

	--print ("HWDEBUG: Adding all buildings to buildinghelper grid")
	local prevEnt
	for i=1, #ALL_LANE_BUILDINGS do 
		local buildingName = ALL_LANE_BUILDINGS[i]
		buildingNameEnt = Entities:FindByName(prevEnt, buildingName)
		-- loop through and get the absOrigin of the buidlings
		local unitName = buildingNameEnt:GetUnitName() -- can be removed
		--print ("Building Name via GetUnitName:" .. unitName)
		local buildingAbsOrigin = buildingNameEnt:GetAbsOrigin()
		--print ("AbsOrigin:")
		--print (buildingAbsOrigin)
		--print ("Max Bounds:")
		local buildingMaxBounds = buildingNameEnt:GetBoundingMaxs()
		--print (buildingMaxBounds)
		--we only need one side as per the docs of building helper
		local x = buildingMaxBounds.x
		--local BHSize = x/64
		local BHSize = 2
		--changed the above to 2 from 2.5, 2015/02/07
		-- ** Add Base Building Blockers so players can't build in base.
		if BASE_BUILDING_BLOCKERS[buildingName] then
			--print ("BASE_BUILDING_BLOCKERS found")
			local BH = BuildingHelper:AddBuildingToGrid(buildingAbsOrigin, 40, nil) --2.34 is based on 150x150
			if BH == -1 then
				print ("HWERROR: Building Helper failed to add something to the grid. Check the next line.")
				print (unitName)
			end
		-- ** Add the farms so players can't build on top of them
		elseif FARM_BUILDINGS[buildingName] then
			--print ("FARM_BUILDINGS found")
			local BH = BuildingHelper:AddBuildingToGrid(buildingAbsOrigin, 4, nil) --2.34 is based on 150x150
			if BH == -1 then
				print ("HWERROR: Building Helper failed to add something to the grid. Check the next line.")
				print (unitName)
			end
		else
		-- ** Add the rest of the buildings, which are towers, to the grid
			local BH = BuildingHelper:AddBuildingToGrid(buildingAbsOrigin, BHSize, nil) --2.34 is based on 150x150
			if BH == -1 then
				print ("HWERROR: Building Helper failed to add something to the grid. Check the next line.")
				print (unitName)
			end
		end
	end


end --end this function

--[[
*** EVENT LISTENER HANDLERS ***
]]

function HeroWarsGameMode:onPlayerLoaded(keys)
--@params
--keys - accepts the table for the loaded player
--Called from C++, this is a game event handler method
--For now this only invokes CaptureGameMode which just sets a few GameMode specifc rules.
--Returns: Nothing

	self:CaptureGameMode()

	--do other stuff when all players loaded like announce shit
	--maybe add here to control all the custom buildings?
	-- print ("HWDEBUG: *** THEY KEYS PASSED TO player_connect_full ***")
	--DeepPrintTable(keys)

	-- print ("HWDEBUG: Printing the PlayerResource information")
	--~ local player = PlayerResource:GetPlayer(0)
	--~ -- unit:SetControllableByPlayer(player:GetPlayerID(), true)
	--~ print (PlayerResource:GetPlayer(0))
	--~ print (player:GetPlayerID())
	--~ print (PlayerResource:GetPlayerName(0))

	--~ print (PlayerResource:GetPlayer(1))
	--~ print (PlayerResource:GetPlayerName(1))

end

function HeroWarsGameMode:OnHeroInGame(hero)
--@params
--hero - the hero that has connected
--Called from C++, this ia game event handler method
--When a hero connects, add them to the vPlayerHeroData table for tracking
--Returns: Nothing
 	--print("HWDEBUG: Hero spawned in game for first time -- " .. hero:GetUnitName()) --printed the hero name dota_npc_hero_leshrac or w/e
	self:_populatePlayerHeroData(hero)

end

-- An NPC has spawned somewhere in game. This includes heroes
function HeroWarsGameMode:OnNPCSpawned(keys)
	--print("HWDEBUG: NPC Spawned")
	--PrintTable(keys)
	local npc = EntIndexToHScript(keys.entindex)
	--print(npc:GetUnitName())

	-- if a hero was spawned, send them on their way
	if npc:IsRealHero() and npc.bFirstSpawned == nil then
		npc.bFirstSpawned = true
		HeroWarsGameMode:OnHeroInGame(npc)
	end

	--BUG: Checking for entities built with Building helper here bugs out, b/c they aren't owned by the player when the entity is created.
end

function HeroWarsGameMode:OnEntityKilled( keys )
	--print( 'HWDEBUG:OnEntityKilled Called' )

	-- DeepPrintTable( keys )

	-- -- The Unit that was Killed
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local killer = nil -- set to nil incase suicide

	--return if there was no attacker (suicide)
	if keys.entindex_attacker == nil then
		return
	end

	local killer = EntIndexToHScript( keys.entindex_attacker ) --[[Returns:handle
	Turn an entity index integer to an HScript representing that entity's script instance.
	]]
	-- DeepPrintTable( killedUnit )
	-- print("Printing name and team")
	-- print(killedUnit:GetName())
	-- print(killedUnit:GetTeam())
	-- -- print(killedUnit:GetOwner()) -- nil on lane creeps causes error
	-- print(killedUnit:GetUnitName())

	--store some local variables for the unit that was killed
	local killedUnitUniqueName = killedUnit:GetName() --unique name "1234_unit_name"
	local killedUnitName = killedUnit:GetUnitName() --name "npc_dota_hero_shredder"
	local killedUnitTeam = killedUnit:GetTeam() --should be the team id 1,2,3,4

	local killerUnitName = killer:GetUnitName()
	--print ("The unit that killed this entity was: " .. killerUnitName)

	--testing this code here (stunt bonus)


	-- *** CHECK FOR FOOD_REFUND_UNITS BEING KILLED ***
	-- all units in this set that are killed refund food.
	-- the bank is also handled here
	if FOOD_REFUND_UNITS[killedUnitName] then
			--now find the owner so I can refund him his food
			if killedUnit:IsOwnedByAnyPlayer() then
				local killedUnitOwnerID = killedUnit:GetOwner():GetPlayerID() -- this bugs out if you set the peons to spawn as part of a wave, who cares? Derp. do it right the first time.
				-- print("HWDEBUG - starting to refund food")
				-- print("HWDEBUG: killedUnitOwnerID = " .. killedUnitOwnerID)
				-- print ("killedUnitName = " .. killedUnitName)

				--add a quick check for the bank, assign it to the bool here so we don't have to do it for every place (if we were to place the check inside the player id loop)
				local bankBool = false
				if killedUnitName == "npc_dota_player_bank" then
					bankBool = true
				end

				--loop through the player table and refund the food and set the hasbank bool to false if necessary
				for i = 1,#self.vPlayerHeroData do
					local heroData = self.vPlayerHeroData[i]
					if heroData.nPlayerID == killedUnitOwnerID then
						--print("HWDEBUG: Actually refunding the food...")
						heroData.nConsumedFood = heroData.nConsumedFood - buildingFoodValues[killedUnitName]

						--update the UI to reflect the refunded food
						self:UpdatePlayerFood(killedUnitOwnerID)

						--if it's a bank that's being refunded, stop the bank timer and update the player table that the player doesn't have a bank
						if bankBool then
							local uniqueTimerName = "bankTimer_" .. killedUnitOwnerID
							Timers:RemoveTimer(uniqueTimerName)
							heroData.bHasBank = false
						end
					end
				end
			end
		--print ("HWDEBUG: A FOOD_REFUND_UNITS UNIT WAS JUST KILLED ON NOES")
	--TODO: Add a means to A) Check if the unit who killed the food_refund_unit is a hero B) check if that hero was not the owner C) Give that hero the appropriate score
	--I think this can be accomplished by just turning this in to a solo if block so other things are else'd off of it
	--i.e. give the refund, and then still do the rest of the checks. dont end after refund
	--DOES IT MATTER??? None of these units contribute to score - score is hero kills + creep wave kills
	-- Hero Death
	elseif killedUnit:IsRealHero() then
		--do stuff for a hero hero

		--check the death location to determine gold loss
	-- 	If hero team == dire then
	--  if InDireRectA(deathspot) then
	-- 	do rectA penalty
	-- 	elseif InDireRectB(deathspot) then
	-- 		do rectB penalty
	-- 		else
	-- 			do default penalty 

		local deathSpot = killedUnit:GetAbsOrigin()
		print ("HWDEBUG: Deathspot = (" .. deathSpot.x .. "," .. deathSpot.y .. ")") 
		print (deathSpot.x)
		print (deathSpot.y)

		local killedUnitGold = killedUnit:GetGold()


		--radiant
		if killedUnitTeam == 2 then
			if InDireRectA(deathSpot.x, deathSpot.y) then
				--rect A penalty
				print ("HWDEBUG: Radiant Hero Died in RectA!")
				killedUnit:SetGold (0, false) --lose all gold
			elseif InDireRectB(deathSpot.x, deathSpot.y) then
				--rect B penalty
				print ("HWDEBUG: Radiant Hero Died in RectB!")
				killedUnit:SetGold (math.floor(killedUnitGold * 0.25), false) --lose 75% gold
			else
				--normal death
				print ("HWDEBUG: Radiant Hero Died outside Enemy Rect")
				killedUnit:SetGold (math.floor(killedUnitGold * 0.5), false) --lose half gold
			end
		elseif killedUnitTeam == 3 then
			--dire
			if InRadiantRectA(deathSpot.x, deathSpot.y) then
				--rect A penalty
				print ("HWDEBUG: Dire Hero Died in RectA!")
				killedUnit:SetGold (0, false) --lose all gold			
			elseif InRadiantRectB(deathSpot.x, deathSpot.y) then
				--rect B penalty
				print ("HWDEBUG: Dire Hero Died in RectB!")
				killedUnit:SetGold (math.floor(killedUnitGold * 0.25), false) --lose 75% gold
			else
				--normal death
				print ("HWDEBUG: Dire Hero Died outside Enemy Rect")
				killedUnit:SetGold (math.floor(killedUnitGold * 0.5), false) --lose half gold
			end
		end
		--PlayerResource:SetGold( keys.PlayerID, PlayerResource:GetGold( keys.PlayerID ) + 1000, true)
		--works!
		-- HWDEBUG: Radiant Hero Died in RectB!
		-- HWDEBUG: Radiant Hero Died in RectA!
		-- HWDEBUG: Radiant Hero Died outside Enemy Rect
		-- HWDEBUG: Dire Hero Died in RectB!
		-- HWDEBUG: Dire Hero Died in RectA!
		-- HWDEBUG: Dire Hero Died outside Enemy Rect
		-- --set the heroes respawn time to 20s
 		--print ("HWDEBUG: Tring to set the respawn time via SetTimeUntilRespawn")
		killedUnit:SetTimeUntilRespawn( 20.0 )
		  -- 10 second delayed, run once using gametime (respect pauses)
		Timers:CreateTimer({
			endTime = 20, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
			callback = function()
				--print ("Hello. I'm running 20 seconds after when I was started.")
				killedUnit:RespawnHero(false,false,false)
			end
		})

		if killer:IsRealHero() then
			local killBonusModifier = 0
			--check for stunt bonus
			--If (life of killing unit >= 99 percent) then Accuracy bonus (+50 gold)
			--if (life of killing unit <= 10 percent) then Insane Stunt Bonus (+150 gold)
			local killerHealth = killer:GetHealth()
			local killerMaxHealth = killer:GetMaxHealth()
			--print ("HWDEBUG: *** TESTING STUNT BONUS ***")
			--print ("HWDEBUG: killerHealth = " .. killerHealth)
			--print ("HWDEBUG: killerMaxHealth = " ..killerMaxHealth)
			--calculate the health ratio
			local healthRatio = killerHealth/killerMaxHealth
			local killerPlayerName = "PLAYERNAMEPLACEHOLDER"
			local killedUnitPlayerName = "PLAYERNAMEPLACEHOLDER"

			killerPlayerName = PlayerResource:GetPlayerName(killer:GetPlayerID())
			--print ("HWDEBUG: killerPlayerName = " .. killerPlayerName)
			killedUnitPlayerName = PlayerResource:GetPlayerName(killedUnit:GetPlayerID())
			--print ("HWDEBUG: killedUnitPlayerName = " .. killedUnitPlayerName)

			if healthRatio >= 0.99 then
				--Accuracy Bonus!
				print ("HWDEBUG: Accuracy Bonus!!")
				GameRules:SendCustomMessage("<font color='#6C0AC8'>ACCURACY BONUS! +50 gold award to " .. killerPlayerName .. " for killing " .. killedUnitPlayerName .. " with more than 99% health.</font>", 0, 0)
				killBonusModifier = 50
			end
			if healthRatio <= 0.10 then
				--Insance Stunt Bonus
				print ("HWDEBUG: Insane Stunt Bonus!!")
				GameRules:SendCustomMessage("<font color='#6C0AC8'>INSANE STUNT BONUS! +150 gold award to " .. killerPlayerName .. " for killing " .. killedUnitPlayerName .. " with less than 10% health.</font>", 0, 0)
				killBonusModifier = 150
			end

			local totalKillBonus = BASE_KILL_BONUS + killBonusModifier
			print ("HWDEBUG: Awarding kill bonus to killer = " .. totalKillBonus)
			killer:ModifyGold(totalKillBonus, true, 0)

			--add points to players score for killing a hero
			local killerPlayerID = killer:GetPlayerID()
			for i = 1,#self.vPlayerHeroData do
				local heroData = self.vPlayerHeroData[i]
				if heroData.nPlayerID == killerPlayerID then
					heroData.nScore = heroData.nScore + 40
				end
			end
		end
	print ("HWDEBUG: A HERO WAS JUST KILLED ON NOES")


	-- Normal Creep Death
	elseif ALL_CREEPS[killedUnitName] then
		--do stuff for then a lane creep dies, either base or summoned each gives gold
		if killedUnitTeam == 2 then
			--radiant creep died
			--give dire gold
			--hero:ModifyGold( nAmount, true, 0 )
			for i = 1,#self.vPlayerHeroData do
				if self.vPlayerHeroData[i].nPlayerTeam == 3 then
					self.vPlayerHeroData[i].hero:ModifyGold(self.nDireGPK, false, 0)
				end
			end
			--print ("HWDEBUG:A radiant unit ".. killedUnitName .. " has died")
			--give every hero the amount of gold per kill
		elseif killedUnitTeam == 3 then
			--dire creep died
			--give radiant gold
			for i = 1,#self.vPlayerHeroData do
				if self.vPlayerHeroData[i].nPlayerTeam == 2 then
					self.vPlayerHeroData[i].hero:ModifyGold(self.nRadiantGPK, false, 0)
				end
			end
			--print ("HWDEBUG:A radiant unit ".. killedUnitName .. " has died")
		end
		--end normal unit death method
		if killer:IsRealHero() then
			local killerPlayerID = killer:GetPlayerID()
			for i = 1,#self.vPlayerHeroData do
				local heroData = self.vPlayerHeroData[i]
				if heroData.nPlayerID == killerPlayerID then
					heroData.nScore = heroData.nScore + 1
					heroData.nCreepKills = heroData.nCreepKills + 1
					return
				end
			end
		end
	end
	--[[
	*** CHECK FOR TOWERS BEING KILLED ***
	Moving this outside of the if/elseif tree b/c there could be overlap (which is bad mostly but in this case ok? - Not all towers can be built and have food cost but we still want to score the towers death)
	Updates the players tower killed count. Maybe later have it increment score by 20 since heroes are 40 and units are 1.
	]]

	if CUSTOM_TOWER_NAMES[killedUnitName] then
		if killer:IsRealHero() then
			local killerPlayerID = killer:GetPlayerID()
			for i = 1,#self.vPlayerHeroData do
				local heroData = self.vPlayerHeroData[i]
				if heroData.nPlayerID == killerPlayerID then
					heroData.nTowersKilled = heroData.nTowersKilled + 1
					return
				end
			end
		end
		print ("HWDEBUG: A TOWER WAS JUST KILLED ON NOES")
	end

	-- *** CHECK FOR BANK BEING KILLED ***
end

function HeroWarsGameMode:OnPlayerChat(keys)
	local ply = self.vUserIds[keys.userid]
	print (ply)
	print(keys.text)
end

--[[
*** END EVENT LISTENER HANDLERS ***
]]

--[[
*** PREGAME SETUP ***
]]
function HeroWarsGameMode:CaptureGameMode()
	print "HWDEBUG: Inside CaptureGameMode, setting the rules"
	if GameMode == nil then
		GameMode = GameRules:GetGameModeEntity()
		GameMode:SetRecommendedItemsDisabled( true )
		GameMode:SetStashPurchasingDisabled( true )
		--GameMode:SetFogOfWarDisabled( true )
		GameMode:SetCameraDistanceOverride( 1404.0 ) --[[Returns:void
		Set a different camera distance; dota default is 1134.
		]]

	end
end

function HeroWarsGameMode:PreGameSetup()
	print ("HWDEBUG: Inside PreGameSetup")
	--do the pregame stuff here
		--try to find the ent_dota_shop entity to modify it directly

	--set the radiant spawn location entities here?
	RADIANT_CREEP_SPAWN_LOCATION = Entities:FindByName( nil, RADIANT_SPAWN_LOCATION_NAME )
	RADIANT_FIRST_WAYPOINT = Entities:FindByName ( nil, RADIANT_START_WAYPOINT_NAME)

	DIRE_CREEP_SPAWN_LOCATION = Entities:FindByName( nil, DIRE_SPAWN_LOCATION_NAME )
	DIRE_FIRST_WAYPOINT = Entities:FindByName ( nil, DIRE_START_WAYPOINT_NAME)
	self:_startCreepWaveTimer()
	self:_SetupCustomBuildings()
	self.PreGameSetupComplete = true

end

function HeroWarsGameMode:EndGame()

	print ("Game over man.")

end

--[[
*** THINKER FUNCTIONS ***
]]

function HeroWarsGameMode:Think()
--~ 	print "HWDEBUG: Inside HeroWarsGameMode:Think"
	-- If the game's over, it's over.
	local self = HeroWarsGameMode

	if GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		-- self._scriptBind:EndThink( "GameThink" )
		self:EndGame()
		return
	end

	-- Track game time, since the dt passed in to think is actually wall-clock time not simulation time.
	local now = GameRules:GetGameTime()
	if self.t0 == nil then
		self.t0 = now
	end
	local dt = now - self.t0
	self.t0 = now

	self:thinkState( dt )
	-- ok dt here is just tracking how often this ticks since there is a discrepacny. dt report either 0.26 or 0.23 when it's told think every 0.25
	--print ("HWDEBUG: dt (delta time) = " .. dt)
	--IDEA: Increment another counter on top of dt to track the time or that's dumb
	--self:_roundThink( dt )

	return 0.25
end


function HeroWarsGameMode:_thinkState_Prep( dt )


	if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
 		--self:_InitCVars() -- leave this in good idea to set up command vars here
 		if not self.PreGameSetupComplete then
 			self:PreGameSetup()
 		end
 	end

	--add in prep work here -- assign control of the neutrals once with a if/then boolean?
	-- if the round has started do nothing (if self.bRoundHasStarted = true nothing happens)

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
		--get all the players here?
	end

	if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		-- Waiting on the game to start...
		return
	end
	--Once we pass this if/then, it kicks off inRound and never comes back. Do any prep work here that needs to fire right before the round?

	--ADD ANNOUNCEMENTS HERE
	--This will read your #popup_title and #popup_body variables from \resource\addon_english.txt
	ShowGenericPopup( "#intro_title", "#intro_body", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )

	--30 seconds after the game starts show the GPK again.
	Timers:CreateTimer({
		endTime = 30,
		callback = function()
			self:_echoGPK()
		end
	})
	--this is right before the round starts
	--setting ingame to true here, will be set to false when in duels
	self.inGame = true

	--try it here, if not here then inside InRound?
	--print ("HWDEBUG:Setting up custom buildings")
	--self:_SetupCustomBuildings()

	 -- start the timers for the duels and for the creep spawns.
	self:_startDuelTimer()
	--self:_startCreepWaveTimer()
	self:_roundTimer()

	--start the score update timer, update every 5 seconds
	self:_topScoreboardUpdateTimer()

	--TODO: Add in a check for inDuel here to change the think state flow
	print ("HWDEBUG: Entering _thinkState_InRound")
	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_InRound' )
	self:thinkState( 0 )
end

function HeroWarsGameMode:_thinkState_InRound( dt )
-- if the round has started do nothing (if self.bRoundHasStarted = true nothing happens)
	if not self.inGame then
		return
	end
	--print ("HWDEBUG: Inside _thinkState_InRound")
	--[[
	Just a thought...
	inroundtime = inroundtime + dt
	if inroundtime > duelTime then start a duel end
	]]

	--working as expected just need to do something with it
	--BUG: Stack overflows b/c this doesn't get reset once the duel stage fires - need to set it back to 0 or something b/c inRound time will be a total
	--need to look at time between duels to I can track from the time the previous duel ends

	--keep this to track the total time in game
	-- self.inRoundTime = self.inRoundTime + dt

	-- self.timeBetweenDuels = self.timeBetweenDuels + dt
	-- if self.timeBetweenDuels > self.duelInterval then
	-- 	print ("HWDEBUG: the duel interval (30s for debugging) should have elapsed.")
	-- 	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_DuelPrep' )
	-- 	self:thinkState( 0 )
	-- 	end
end

function HeroWarsGameMode:_thinkState_DuelPrep( dt )

	--print ("HWDEBUG: Inside _thinkState_DuelPrep")

	--doesnt work in _thinkState_Prep b/c it only fires when the round starts (right before it switches to round Begin) . If players haven't picked and the rounds starts, they dont get added
	--i'm thinking i need to call this during the first series of InRound thinks. If a player hasn't connected by the first duel likely they are dc
	--so set something to let me know to stop this. Flip something true in duel and start it as false. When duel think runs sets it to true.
	--also need scores locked in at duelPrep - do it there.
	--or maybe I only need to populate the table once at duel prep since the scores will be calculated then??
	-- self:_populatePlayerHeroData()

	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_InDuel' )
	self:thinkState( 0 )
end

function HeroWarsGameMode:_thinkState_InDuel( dt )
	--[[
	Think state for during the duel. Make two players duel and wait for one to do then send to postDuel. Check for hacks, whatever else needs checking
	during the duel or "thought about"
	]]
	--print ("HWDEBUG: Inside _thinkState_InDuel")

	--when the duel ends fire this
	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_postDuel' )
	self:thinkState( 0 )
end

function HeroWarsGameMode:_thinkState_postDuel( dt )
	--[[
	Think state for after the duel. Give out rewards, punish both players if no one dies. Give others rewards for bets (way later)
	Also do any cleanup?
	]]
	--print ("HWDEBUG: Inside _thinkState_postDuel")

	--set the timeBetweenDuels back to 0
	self.timeBetweenDuels = 0
	--after postDuel set the think state back to ingame
	self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_InRound' )
	self:thinkState( 0 )

	--this should start the next duel timer....
	print("HWDEBUG:Starting the next duel timer")
	self:_startDuelTimer()
end

--[[
*** END THINKERS ***
]]

--[[
*** ROUND METHODS ***
]]

function HeroWarsGameMode:StartRoundFour()
	
	self:_startCreepWaveTimerRoundFour()
	self:UpgradeBrooders(3)

end


--[[
*** END ROUND METHODS ***
]]
--[[
*** TIMERS ***
]]

function HeroWarsGameMode:_startDuelTimer()
	print ("HWDEBUG: Duel timer started.")

	--GameRules:SendCustomMessage("<font color='#C80E0A'>The next duel is in " .. self.duelInterval .. " seconds.</font>", 0, 0)
  -- -- A timer running every second that starts 5 seconds in the future, respects pauses
  -- 	Timers:CreateTimer(self.duelInterval, function()
		-- print ("HWDEBUG: A duel should be starting!!")
		-- self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_DuelPrep' )
		-- self:thinkState( 0 )
		-- return self.duelInterval
  --   end
  -- )

	-- 10 second delayed, run once using gametime (respect pauses)
	Timers:CreateTimer({
		endTime = self.duelInterval, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		callback = function()
		--print ("HWDEBUG:Timer:DUEL TIMER - every " .. self.duelInterval .. " seconds after when I was started.")
		self.thinkState = Dynamic_Wrap( HeroWarsGameMode, '_thinkState_DuelPrep' )
		self:thinkState( 0 )
	end
  })

end

function HeroWarsGameMode:_startCreepWaveTimer()
--starts the base creep wave timer
	print ("HWDEBUG: Base creep wave spawning started.")
	Timers:CreateTimer(function()
		--print ("HWDEBUG:Timer:CREEP WAVE TIMER - Run immediately then every 2.5s")
		if not self.InDuel then
			self:SpawnRadiantUnits()
			self:SpawnDireUnits()
		end
		--TODO:add a clause in here to ensure we aren't in a duel
	return 1.25
	end
	)
end

function HeroWarsGameMode:_startCreepWaveTimerRoundFour()
	-- A timer running every 30 seconds that starts immediately on the next frame, respects pauses
	-- Timers:CreateTimer(function()
	-- 	print ("HWDEBUG:Timer:CREEP WAVE TIMER - Run immediately then every 30s")
	-- 	self:SpawnRadiantUnits()
	-- 	self:SpawnDireUnits()
	-- return 30.0
	-- end
	-- )
	print ("HWDEBUG:Timer:CREEP WAVE ROUND FOUR TIMER STARTED")
	Timers:CreateTimer(function()
		--print ("HWDEBUG:Timer:CREEP WAVE ROUND FOUR TIMER - Run immediately then every 6s")
		if not self.InDuel then
			self:SpawnRadiantUnitsRoundFour()
			self:SpawnDireUnitsRoundFour()
		end
		--TODO:add a clause in here to ensure we aren't in a duel
	return 6
	end
	)
end

function HeroWarsGameMode:_startCustomCreepWaveTimer( something )
end

function HeroWarsGameMode:_roundTimer()
	--ROUND TIMER - FIRES EVERY ROUND - BASED ON EVERY 2 DUELS
	--Currently used to upgrade the number of creeps spawned.
	-- A timer running every second that starts in 60 seconds and repeats every 60 seconds - set to 10 mins, respects pauses
	Timers:CreateTimer(ROUND_TIME, function()
		--print ("HWDEBUG:Timer:ROUNDTIMER: Run after 1 (10) minute and then every 10 (1 for testing) minutes thereafter.")
		--calculate the GPK
		self:_calculateGPK()
		--increase the round number
		if self.nRoundNumber < 4 then
			self.nRoundNumber = self.nRoundNumber + 1
			print ("HWDEBUG: *** ROUND " .. self.nRoundNumber .. " STARTED ***")
			local messageinfo = {
				message = "Round " .. self.nRoundNumber .. " Started!",
				duration = 5 -- milliseconds ?? no it just flashes no matter what this is set to
				}
			FireGameEvent("show_center_message",messageinfo)
			self:_showRoundMessages()
			--add in traps for certain rounds
			--there are only 4 rounds - stop this timer when round 4 occurs
			if self.nRoundNumber == 4 then
				--print ("HWDEBUG: Round four methods being initialized.")
				self:StartRoundFour()
			end
		end
		return ROUND_TIME
	end
	)
end

function HeroWarsGameMode:_topScoreboardUpdateTimer()
	print ("HWDEBUG: Starting score timer.")
	Timers:CreateTimer(function()
		if not self.InDuel then
			self:_calculateTeamScores()

		end
	return 2.0
	end
	)
end
--[[
*** END TIMERS SECTION ***
]]

--[[
*** ECHO FUNCTIONS ***
]]

function HeroWarsGameMode:_echoGPK()

	-- print ("HWDEBUG: GPK Calculated:")
	-- print ("Radiant GPK = " .. self.nRadiantGPK)
	-- print ("Dire GPK = " .. self.nDireGPK)
	-- print("Number of players per team:")
	-- print("Radiant = " .. self.nRadiantPlayers)
	-- print("Dire = " .. self.nDirePlayers)
	GameRules:SendCustomMessage("<font color='#EAB416' face='Dota Hypatia Bold'><b>Number of Radiant Players: " .. self.nRadiantPlayers .. "</b></font>", 0, 0)
	GameRules:SendCustomMessage("<font color='#EAB416' face='Dota Hypatia Bold'><b>Radiant GPK: " .. self.nRadiantGPK .. "</b></font>", 0, 0)
	GameRules:SendCustomMessage("<font color='#EAB416' face='Dota Hypatia Bold'><b>Number of Dire Players: " .. self.nDirePlayers .. "</b></font>", 0, 0)
	GameRules:SendCustomMessage("<font color='#EAB416' face='Dota Hypatia Bold'><b>Dire GPK: " .. self.nDireGPK .. "</b></font>", 0, 0)
end

function HeroWarsGameMode:_echoRoundTwo()

	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>*** Round Two Started ***</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Gold increase of +1 per kill</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Master Peon can be trained</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Level 2 Archer Reinforcements available</font>", 0, 0)
	Say(nil,"* Round Two Started *", false)
	Say(nil,"Gold increase of +1 per kill", false)
	Say(nil,"Master Peon can be trained", false)
	Say(nil,"Level 2 Archer Reinforcements available", false)
end

function HeroWarsGameMode:_echoRoundThree()

	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'>*** Round Three Started ***<b></font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Gold increase of +1 per kill</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Windigo Brats Wave available</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Bomb Squads can be trained</font>", 0, 0)
	--GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Superior Archers can be trained</font>", 0, 0)
	Say(nil,"* Round Three Started *", false)
	Say(nil,"Gold increase of +1 per kill", false)
	Say(nil,"Windigo Brats Wave available", false)
	Say(nil,"Bomb Squads can be trained", false)
	Say(nil,"Superior Archers can be trained", false)
end

function HeroWarsGameMode:_echoRoundFour()

	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>*** Round Four Started ***</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Gold increase of +1 per kill</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Golems will now spawn periodically</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Hydralisks Wave available</font>", 0, 0)
	-- GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>Level 3 Archer Reinforcements available</font>", 0, 0)
	--GameRules:SendCustomMessage("<font color='#848484' face='Dota Hypatia Bold'><b>+200% experience earned</font>", 0, 0)
	Say(nil,"* Round Four Started *", false)
	Say(nil,"Gold increase of +1 per kill", false)
	Say(nil,"Golems will now spawn periodically", false)
	Say(nil,"Hydralisks Wave available", false)
	Say(nil,"Level 3 Archer Reinforcements available", false)
end

function HeroWarsGameMode:_showRoundMessages()
	--echo GPK
	self:_echoGPK()
	if self.nRoundNumber == 2 then self:_echoRoundTwo() end
	if self.nRoundNumber == 3 then self:_echoRoundThree() end
	if self.nRoundNumber == 4 then self:_echoRoundFour() end
end

--[[
*** END ECHO FUNCTIONS ***
]]
--[[
*** POPULATE PLAYERHERODATA ***
]]

function HeroWarsGameMode:_populatePlayerHeroData(hero)
	print ("HWDEBUG: Populating Hero Data")
	if hero and hero:IsRealHero() then
		--print("hero was true and hero:IsRealHero - I already checked for this though...")
		local nPlayerID = hero:GetPlayerID()
		local nPlayerTeam = hero:GetTeamNumber()
		local playerName = PlayerResource:GetPlayerName(nPlayerID)
		if playerName == "" then playerName = "PLAYER_NAME_BLANK-" .. nPlayerID end
		local bWasFound = false
		for j=1,#self.vPlayerHeroData do --for every record in the vPlayerHeroData table
			--check to see if the hero already exists
			if self.vPlayerHeroData[j].nPlayerID == nPlayerID then --if the existing entry of vPlayerHeroData's playerID == the player ID of the hero from the hero list then
			self.vPlayerHeroData[j].hero = hero -- then set the vPlayerHeroData hero value to the heroEntity - are we just updating the reference here?
			bWasFound = true --the hero was found in the table already
			break
		end
	end
	--for heroes that were not already in the vPlayerHeroData table, add them with the hero value being the heroEntity and all else to 0 and also setting the playerID
	-- *** SET UP A NEW HERO ***
	if not bWasFound then --bWasFound must be false to proceed
		--update the counts of the teams		
		if nPlayerTeam == 2 then
			self.nRadiantPlayers = self.nRadiantPlayers + 1
			self.RadiantPlayerSlot = self.RadiantPlayerSlot + 1
			nRadiantPlayerSlot = self.RadiantPlayerSlot
			nDirePlayerSlot = 0
			print("HWDEBUG: Radiant Player Joined")
			print ("HWDEBUG: Radiant Player Slot = " .. nRadiantPlayerSlot)
			--why dont i just assign ownership to the hero now?
			self:_assignRadiantBuildingOwnership(nRadiantPlayerSlot, nPlayerID)
		elseif nPlayerTeam == 3 then
			self.nDirePlayers = self.nDirePlayers + 1
			self.DirePlayerSlot = self.DirePlayerSlot + 1
			nDirePlayerSlot = self.DirePlayerSlot
			nRadiantPlayerSlot = 0
			print("HWDEBUG: Dire Player Joined")
			print ("HWDEBUG: Dire Player Slot = " .. nDirePlayerSlot)
			self:_assignDireBuildingOwnership(nDirePlayerSlot, nPlayerID)
		end
		--define and populate the hero data table
		--print ("HWDEBUG: IS LOCAL PERSISTING THIS FAR???")
		--print ("HWDEBUG: Radiant Player Slot = " .. nRadiantPlayerSlot)
		--print ("HWDEBUG: Dire Player Slot = " .. nDirePlayerSlot)

		local heroTable = {
			hero = hero,
			playerName = playerName,
			nPlayerTeam = nPlayerTeam,
			nMaxFood = 19,
			nConsumedFood = 0,
			nTotalWood = 5000,
			bHasBank = false,
			nCreepKills = 0,
			nTowersKilled = 0,
			nHeroesKilled = 0,
			nTowersBuilt = 0,
			nScore = 0,

			-- nCreepKillsThisRound = 0,
			-- nGoldBagsCollected = 0,
			-- nGoldBagsCollectedThisRound = 0,
			-- nDamageDealt = 0,
			-- nDamageTaken = 0,
			-- nPriorRoundDeaths = 0,
			-- nRevivesDone = 0,
			-- nHealthRestored = 0,
			nPlayerID = nPlayerID,
			nDirePlayerSlot = nDirePlayerSlot,
			nRadiantPlayerSlot = nRadiantPlayerSlot
		}
		table.insert( self.vPlayerHeroData, heroTable ) --insert the new hero in to the table
		self:_calculateGPK()
		-- set the heroes gold to 0 at the start
		print("HWDEBUG: Setting the players gold to 0 at the start (10000 for testing since 0 works)")
		--PlayerResource:SetGold(0, 0, false)
		local heroStartingGold = hero:GetGold() -- get the base hero starting gold, 625
		hero:SetGold(heroStartingGold - 625 + PLAYER_STARTING_GOLD, false) --bring everyone who didn't random to 0
		end
	end
end

function HeroWarsGameMode:_assignRadiantBuildingOwnership(playerSlot, playerID)

	radiantBuildingSets = {radiantPlayer1Buildings, radiantPlayer2Buildings, radiantPlayer3Buildings, radiantPlayer4Buildings, radiantPlayer5Buildings}

	for i = 1, #radiantBuildingSets[playerSlot] do
    	local playerBuildingsEnt = Entities:FindByName( nil, radiantBuildingSets[playerSlot][i] )
 		local playerBuildingEntIdx = playerBuildingsEnt:GetEntityIndex()
 		local playerBuilding = EntIndexToHScript(playerBuildingEntIdx)
 		local playerOwner = PlayerResource:GetPlayer(playerID)
 		playerBuilding:SetControllableByPlayer(playerID, true)
		playerBuilding:SetOwner(playerOwner)
 	end
end

function HeroWarsGameMode:_assignDireBuildingOwnership(playerSlot, playerID)

	direBuildingSets = {direPlayer1Buildings, direPlayer2Buildings, direPlayer3Buildings, direPlayer4Buildings, direPlayer5Buildings}

	for i = 1, #direBuildingSets[playerSlot] do
    	local playerBuildingsEnt = Entities:FindByName( nil, direBuildingSets[playerSlot][i] )
 		local playerBuildingEntIdx = playerBuildingsEnt:GetEntityIndex()
 		local playerBuilding = EntIndexToHScript(playerBuildingEntIdx)
 		local playerOwner = PlayerResource:GetPlayer(playerID)
 		playerBuilding:SetControllableByPlayer(playerID, true)
		playerBuilding:SetOwner(playerOwner)
 	end
end

--[[
Used to calculate the gpk of each team. Should be called every time a player abandons or joins for the first time. Also at every round interval.
]]
function HeroWarsGameMode:_calculateGPK()
	local roundModifier = self.nRoundNumber

	--radiant
	if self.nRadiantPlayers == 0 then
		--no players so dont leave ppl stack while away at the start? Otherwise this wont matter maybe bots?
		self.nRadiantGPK = 0

	elseif self.nRadiantPlayers == 1 then
		self.nRadiantGPK = roundModifier + 9

	elseif self.nRadiantPlayers == 2 then
		self.nRadiantGPK = roundModifier + 8

	elseif self.nRadiantPlayers == 3 then
		self.nRadiantGPK = roundModifier + 7

	elseif self.nRadiantPlayers == 4 then
		self.nRadiantGPK = roundModifier + 6

	elseif self.nRadiantPlayers == 5 then
		self.nRadiantGPK = roundModifier + 5

	end

	--dire
	if self.nDirePlayers == 0 then
		--no players so dont leave ppl stack while away at the start? Otherwise this wont matter maybe bots?
		self.nDireGPK = 0

	elseif self.nDirePlayers == 1 then
		self.nDireGPK = roundModifier + 9

	elseif self.nDirePlayers == 2 then
		self.nDireGPK = roundModifier + 8

	elseif self.nDirePlayers == 3 then
		self.nDireGPK = roundModifier + 7

	elseif self.nDirePlayers == 4 then
		self.nDireGPK = roundModifier + 6

	elseif self.nDirePlayers == 5 then
		self.nDireGPK = roundModifier + 5

	end

	print ("HWDEBUG: GPK Calculated:")
	print ("Radiant GPK = " .. self.nRadiantGPK)
	print ("Dire GPK = " .. self.nDireGPK)
end


--[[
*** CREEP SPAWNING ***
]]

function HeroWarsGameMode:SpawnRadiantUnits()

	--print ("HWDEBUG: Spawning Radiant Base Creep Wave Units.")
	local spawnOffset1 = RandomFloat( 0, 400 )
	local spawnOffset2 = RandomFloat( 0, 400 )
	local spawnOffsetVector = Vector(spawnOffset1, spawnOffset2, 0)
	local creature = CreateUnitByName( RADIANT_BASE_WAVE_CREEPS[self.radiantCreepLvl] , RADIANT_CREEP_SPAWN_LOCATION:GetAbsOrigin() + spawnOffsetVector, true, nil, nil, DOTA_TEAM_GOODGUYS )
	creature:SetInitialGoalEntity( RADIANT_FIRST_WAYPOINT )
	--print ("HWDEBUG: Radiant base creep wave unit creation completed.")

end


function HeroWarsGameMode:SpawnDireUnits()

	--print ("HWDEBUG: Spawning Dire Base Creep Wave Units.")
	local spawnOffset1 = RandomFloat( 0, 400 )
	local spawnOffset2 = RandomFloat( 0, 400 )
	local spawnOffsetVector = Vector(spawnOffset1, spawnOffset2, 0)
	local creature = CreateUnitByName( DIRE_BASE_WAVE_CREEPS[self.direCreepLvl], DIRE_CREEP_SPAWN_LOCATION:GetAbsOrigin() + spawnOffsetVector, true, nil, nil, DOTA_TEAM_BADGUYS )
	creature:SetInitialGoalEntity( DIRE_FIRST_WAYPOINT )
	--print ("HWDEBUG: Dire base creep wave unit creation completed.")

end

function HeroWarsGameMode:SpawnRadiantUnitsRoundFour()

	--print ("HWDEBUG: Spawning Radiant Base Creep Wave Units for Round Four.")
	local creature = CreateUnitByName( "npc_dota_golem_radiant_roundfour" , RADIANT_CREEP_SPAWN_LOCATION:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_GOODGUYS )
	creature:SetInitialGoalEntity( RADIANT_FIRST_WAYPOINT )
	--print ("HWDEBUG: Radiant base creep wave additional round 4 unit creation completed.")
	radiantRoundFourSpawnCount = radiantRoundFourSpawnCount + 1
	--print ("Number of Radiant Round 4 Creeps = " .. radiantRoundFourSpawnCount)
end

function HeroWarsGameMode:SpawnDireUnitsRoundFour()

	--print ("HWDEBUG: Spawning Dire Base Creep Wave Units for Round Four.")
	local creature = CreateUnitByName( "npc_dota_golem_dire_roundfour" , DIRE_CREEP_SPAWN_LOCATION:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	creature:SetInitialGoalEntity( DIRE_FIRST_WAYPOINT )
	--print ("HWDEBUG: Dire base creep wave additional round 4 unit creation completed.")
	direRoundFourSpawnCount = direRoundFourSpawnCount + 1
	--print ("Number of Dire Round 4 Creeps = " .. direRoundFourSpawnCount)


end

--[[
For spawning the waves heroes can summon from their barracks.
]]

function HeroWarsGameMode:SpawnSpecialWaveUnits(unitType, team)
	--this is only called externally from custom_abilities.lua

	-- RADIANT_FIRST_WAYPOINT
	-- RADIANT_CREEP_SPAWN_LOCATION
	--print ("HWDEBUG: DEBUG: Inside SpawnSpecialWaveUnits")
	--print ("HWDEBUG: unitType = " .. unitType)
	--print ("HWDEBUG: team = " .. team)

	--[[
	If unit type is windigo and round > 3 then unitType = npc_dota_windigo_brat?
	]]
	
	-- Here is where custom units can be summoned
	-- start with just two, then expand to 6 total (the max ability slots)
	-- the number of creeps spawned will be dependent on the type?
	-- pseudocode
	-- if unityType = orc then
	-- spawn 6 orc owned by the team that spawned then
	--if unitType = troll then
	-- spawn 3 trolls owned blah
	-- etc

	--the incoming team is a number, will need to convert to who requested

	--we need to check the team so we can upgrade that team, the player in this case only matters for charging gold.
	-- TEAMS - 1 - neutrals, 2 - radiant, 3 - dire - I THINK!!!!
	local spawnLocation
	local waypoint
	local numberToSpawn = 0
	local waves = 0

	if team == 2 then
		print ("RADIANT Special Creep Wave Spawn Triggered")
		spawnLocation = RADIANT_CREEP_SPAWN_LOCATION
		waypoint = RADIANT_FIRST_WAYPOINT

	elseif team == 3 then
		print ("DIRE Special Creep Wave Spawn Triggered")
		spawnLocation = DIRE_CREEP_SPAWN_LOCATION
		waypoint = DIRE_FIRST_WAYPOINT
	end

	--this can totally be a table
	--windigo/brats/hydras
	if unitType == "npc_dota_wave_windigo" then
		numberToSpawn = 2
		waves = 5
	elseif unitType == "npc_dota_wave_windigo_brat" then
		numberToSpawn = 2
		waves = 5
	elseif unitType == "npc_dota_wave_hydralisk" then
		numberToSpawn = 2
		waves = 6
	end

	--archer reinforcements
	if unitType == "npc_dota_wave_archer_reinforcements_lvlone" then
		numberToSpawn = 3
		waves = 10
	elseif unitType == "npc_dota_wave_archer_reinforcements_lvltwo" then
		numberToSpawn = 3
		waves = 10
	elseif unitType == "npc_dota_wave_archer_reinforcements_lvlthree" then
		numberToSpawn = 3
		waves = 10
	end
	
	--testing/play
	if unitType == "npc_dota_furbolg_champion" then
		numberToSpawn = 3
	end
	if unitType == "npc_dota_black_dragon" then
		numberToSpawn = 1
	end

	
	local j = 1
	local waveInterval = 0.0
	while waves>=j do
		if not self.InDuel then
			waveInterval = waveInterval + 2.0
		end
		--inject the duel checks here!
		--use a queue, store how many times would have b een created
		--or rename timers and pause them
		--or even better maybe? is to check if InDuel before creating each timer and if so dont do it, and also dont increment the while loop(s?) so that we dont lose our spot and the while loop can resume when InDuel is false again (perfect?)
		--this is a good idea, but as it is now it causes a hang if "pause" during a special wave spawn b/c of the inner while loop 'i'
		if not self.InDuel then
			Timers:CreateTimer({
				endTime = waveInterval, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
				callback = function()
					local i = 1
					local specialCreepWaveSpawnTime = 0.0
					while numberToSpawn>=i do
						if not self.InDuel then
							specialCreepWaveSpawnTime = specialCreepWaveSpawnTime + 0.3
						end
						--print("Creating Timer for creeps, specialCreepWaveSpawnTime = " .. specialCreepWaveSpawnTime)
						if not self.InDuel then
							Timers:CreateTimer({
								endTime = specialCreepWaveSpawnTime, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
								callback = function()
									--print ("HWDEBUG:Timer:Spawning the invidividual MELEE creeps with an 0.3 second offset (that's what I scraped up on the inet that the info_target does for the default spawner)")
									--hscript CreateUnitByName( string name, vector origin, bool findOpenSpot, hscript, hscript, int team)
									local spawnOffset1 = RandomFloat( 0, 200 )
									local spawnOffset2 = RandomFloat( 0, 200 )
									local spawnOffsetVector = Vector(spawnOffset1, spawnOffset2, 0)
									local creature = CreateUnitByName( unitType, spawnLocation:GetAbsOrigin() + spawnOffsetVector, true, nil, nil, team )
									-- the wolf takes the corner at normal speed and doesn't get fucked up...
									--local creature = CreateUnitByName( "npc_dota_lycan_wolf4" , spawnLocation:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_GOODGUYS )
									--print ("HWDEGUB:create unit has run")
									creature:SetInitialGoalEntity( waypoint )
								end
							})
							if not self.InDuel then
								i = i + 1
							end
						end
					end
				end
			})
			if not self.InDuel then
				j = j + 1
			end
		end
	end


	-- local i = 1
	-- local creepSpawnTime = 0.0
 	-- while self.baseMeleeSpawnCount>=i do
	-- 		-- 10 second delayed, run once using gametime (respect pauses)
	-- 		--[[

	-- 			-- Track game time, since the dt passed in to think is actually wall-clock time not simulation time.
	-- 			local now = GameRules:GetGameTime()
	-- 			if self.t0 == nil then
	-- 				self.t0 = now
	-- 			end
	-- 			local dt = now - self.t0
	-- 			self.t0 = now

	-- 		initial time = now

	-- 		next creep time = now + 0.3
	-- 		next creep time after that = next creep time + 0.3
	-- 		repeat
	-- 		]]
	-- 		--create one timer per loop through?
	-- 	creepSpawnTime = creepSpawnTime + 0.3
	-- 	print("Creating Timer for creeps, meleeCreepSpawnTime = " .. creepSpawnTime)
	-- 	Timers:CreateTimer({
	-- 		endTime = creepSpawnTime, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
	-- 		callback = function()
	-- 			print ("Spawning the invidividual MELEE creeps with an 0.3 second offset (that's what I scraped up on the inet that the info_target does for the default spawner)")
	-- 			--hscript CreateUnitByName( string name, vector origin, bool findOpenSpot, hscript, hscript, int team)
	-- 			local spawnOffset1 = RandomFloat( 0, 200 )
	-- 			local spawnOffset2 = RandomFloat( 0, 200 )
	-- 			local spawnOffsetVector = Vector(spawnOffset1, spawnOffset2, 0)
	-- 			local creature = CreateUnitByName( RADIANT_BASE_WAVE_CREEPS[self.radiantCreepLvl], spawnLocation:GetAbsOrigin() + spawnOffsetVector, true, nil, nil, DOTA_TEAM_GOODGUYS )
	-- 			-- the wolf takes the corner at normal speed and doesn't get fucked up...
	-- 			--local creature = CreateUnitByName( "npc_dota_lycan_wolf4" , spawnLocation:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_GOODGUYS )
	-- 			print ("create unit has run")
	-- 			--Sets the waypath to follow. path_wp1 in this example
	-- 			creature:SetInitialGoalEntity( waypointlocation )
	-- 		end
	-- 	})
	-- 		-- local spawnOffset1 = RandomFloat( 0, 200 )
	-- 		-- local spawnOffset2 = RandomFloat( 0, 200 )
	-- 		-- local spawnOffsetVector = Vector(spawnOffset1, spawnOffset2, 0)
	-- 		-- --maybe break this out in to doSpawn?
	-- 		-- -- nah maybe just have the
	-- 		-- local creature = CreateUnitByName( RADIANT_BASE_WAVE_CREEPS[self.radiantCreepLvl] , spawnLocation:GetAbsOrigin() + spawnOffsetVector, true, nil, nil, DOTA_TEAM_GOODGUYS )
	-- 		-- -- the wolf takes the corner at normal speed and doesn't get fucked up...
	-- 		-- --local creature = CreateUnitByName( "npc_dota_lycan_wolf4" , spawnLocation:GetAbsOrigin() + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_GOODGUYS )
	-- 		-- print ("create unit has run")
	-- 		-- --Sets the waypath to follow. path_wp1 in this example
	-- 		-- creature:SetInitialGoalEntity( waypointlocation )
	-- 		-- DeepPrintTable(creature)
	-- 		i = i + 1
 --    end
end

--[[
Helper Methods
--]]

function HeroWarsGameMode:UpgradeBrooders(upgradeLevel)
	print ("HWDEBUG: Upgrading the brooders for increased hydra channel time")
	--this method upgrades the brooders so the cooldown for hyrdas can be increased based on its level
	for i = 1,#self.vPlayerHeroData do
		if self.vPlayerHeroData[i].nPlayerTeam == 2 then
			--get the building slot
			local playerSlot = self.vPlayerHeroData[i].nRadiantPlayerSlot
			local brooderName = "Radiant_Brooder_Player" .. playerSlot
			local brooderEnt = Entities:FindByName( nil, brooderName )
			local brooderEntIdx = brooderEnt:GetEntityIndex()
			local brooder = EntIndexToHScript(brooderEntIdx)
			local ability1 = brooder:GetAbilityByIndex(0) -- this should be summon windigo/brats/hydras but lets check
			local abiName = ability1:GetAbilityName()
			if abiName == "summon_wave_windigo" then
				ability1:SetLevel(upgradeLevel) --works
			end

		end
		if self.vPlayerHeroData[i].nPlayerTeam == 3 then
			--get the building slot
			local playerSlot = self.vPlayerHeroData[i].nDirePlayerSlot
			local brooderName = "Dire_Brooder_Player" .. playerSlot
			local brooderEnt = Entities:FindByName( nil, brooderName )
			local brooderEntIdx = brooderEnt:GetEntityIndex()
			local brooder = EntIndexToHScript(brooderEntIdx)
			local ability1 = brooder:GetAbilityByIndex(0) -- this should be summon windigo/brats/hydras but lets check
			local abiName = ability1:GetAbilityName()
			if abiName == "summon_wave_windigo" then
				ability1:SetLevel(upgradeLevel) --works
			end
		end
	end

end

--[[
DEBUG FUNCTIONS
--]]

function entityIterator()
	print("*** HWDEBUG: *** DEBUG *** Attempting to iterate over all entities ***")
	--attempt to iterate through all entities
	--not yet only if desperate
	local firstEnt = Entities:First()
	print (firstEnt)
	local nextEnt = Entities:Next(firstEnt)
	while nextExt ~= nil do
		print (nextEnt)
		nextEnt = Entities:Next(nextEnt)
	end
end


function printTable( t, indent )
	for k,v in pairs( t ) do
        if type( v ) == "table" then
        	if ( v ~= t ) then
				print( indent..tostring(k)..":\n"..indent.."{" )
        		printTable( v, indent.."  " )
				print( indent.."}" )
        	end
        else
        	print( indent..tostring(k)..":"..tostring(v) )
        end
    end
end

--[[
_debugPlayersInfo

Used to gather the information about the players by ID. Used to see when the player data is actually loaded.
Simply attach self._debugPlayersInfo() in to any function to get the players info
--]]
function HeroWarsGameMode:_debugPlayersInfo()
	print ("HWDEBUG: *** PLAYERS INFO ***")
	for i = 0, 9, 1 do
		print ("HWDEBUG: Player ID: " .. i)
		print ("HWDEBUG: Is that a valid player ID?")
		print (PlayerResource:IsValidPlayerID(i))
		print ("HWDEBUG: Is this player ID a valid player?")
		print (PlayerResource:IsValidPlayer(i))
		local thisPlayer = PlayerResource:GetPlayer(i) -- this will work, it will store the CODOTAPlayer
		if thisPlayer ~= nil then
			for k, playerInfo in pairs(thisPlayer) do
				print (playerInfo)
			end
		else
			print ("HWDEBUG: No player was found at player ID: " .. i)
		end
	end

	for _,heroData in ipairs(HeroWarsGameMode.vPlayerHeroData) do
		for i,v in pairs(heroData) do print (i, v) end
	end
	print("Number of players per team:")
	print("Radiant = " .. self.nRadiantPlayers)
	print("Dire = " .. self.nDirePlayers)
end

--[[

UI COMMAND AND SCORES

]]

function HeroWarsGameMode:_calculateTeamScores()

	local totalDireScore = 0
	local totalRadiantScore = 0

	for _,heroData in ipairs(self.vPlayerHeroData) do
		--radiant
		if heroData.nPlayerTeam == 2 then
			totalRadiantScore = totalRadiantScore + heroData.nScore
		end
		--dire
		if heroData.nPlayerTeam == 3 then
			totalDireScore = totalDireScore + heroData.nScore
		end
	end

	-- print("Radiant Score: " .. totalRadiantScore)
	-- print("Dire Score: " .. totalDireScore)

	--Update the top scoreboard with the values
	self:UpdateTopScoreboard(totalRadiantScore, totalDireScore)
end


function HeroWarsGameMode:UpdatePlayerFood(nPlayerID)

	print ("Updating player UI - FOOD")

	local currentFood = 0

	for _,heroData in ipairs(self.vPlayerHeroData) do
		--for i,v in pairs(heroData) do print (i, v) end
		if heroData.nPlayerID == nPlayerID then
			currentFood = heroData.nMaxFood - heroData.nConsumedFood
		end
	end

	print("Current Food = " .. currentFood)

	local event_data =
	{
	    foodValue = currentFood
	}

	
	--local team_number = 1

	local player_entity = PlayerResource:GetPlayer(nPlayerID) 

	--CustomGameEventManager:Send_ServerToAllClients( "my_event_name", event_data )
	--CustomGameEventManager:Send_ServerToTeam( team_number, "my_event_name", event_data )
	CustomGameEventManager:Send_ServerToPlayer( player_entity, "update_player_food", event_data )

end

function HeroWarsGameMode:UpdatePlayerWood(nPlayerID)

	print ("Updating player UI - WOOD")

	local currentWood = 0

	for _,heroData in ipairs(self.vPlayerHeroData) do
		--for i,v in pairs(heroData) do print (i, v) end
		if heroData.nPlayerID == nPlayerID then
			currentWood = heroData.nTotalWood
		end
	end

	print("Current Wood = " .. currentWood)

	local event_data =
	{
	    woodValue = currentWood
	}

	
	--local team_number = 1

	local player_entity = PlayerResource:GetPlayer(nPlayerID) 

	--CustomGameEventManager:Send_ServerToAllClients( "my_event_name", event_data )
	--CustomGameEventManager:Send_ServerToTeam( team_number, "my_event_name", event_data )
	CustomGameEventManager:Send_ServerToPlayer( player_entity, "update_player_wood", event_data )

end

function HeroWarsGameMode:UpdateTopScoreboard(nRadiantScore, nDireScore)

	local event_data =
	{
	    radiantScore = nRadiantScore or 0,
	    direScore = nDireScore or 0
	}

	
	--local team_number = 1

	--local player_entity = PlayerResource:GetPlayer(nPlayerID) 

	CustomGameEventManager:Send_ServerToAllClients( "update_team_scores", event_data )
	--CustomGameEventManager:Send_ServerToTeam( team_number, "my_event_name", event_data )
	--CustomGameEventManager:Send_ServerToPlayer( player_entity, "update_player_food", event_data )

end
--[[

CONSOLE COMMANDS

]]

function HeroWarsGameMode:_HWConsoleScore()
	print (self.nRoundNumber)
	print( string.format( 'Round number %d', self.nRoundNumber ) )
	for i = 1,#self.vPlayerHeroData do
		local heroNameTmp = self.vPlayerHeroData[i].hero:GetUnitName()
		--if self.vPlayerHeroData[i].nPlayerID
		print ( string.format ( 'Player Name: %s', self.vPlayerHeroData[i].playerName))
		print ( string.format ( 'Hero Name: %s', heroNameTmp))
		print ( string.format ( 'Score: %d', self.vPlayerHeroData[i].nScore))
		print ( string.format ( 'Heroes Killed: %d', self.vPlayerHeroData[i].nHeroesKilled))
		print ( string.format ( 'Towers Killed: %d', self.vPlayerHeroData[i].nTowersKilled))
		print ( string.format ( 'Units Killed: %d', self.vPlayerHeroData[i].nCreepKills))
		print ( string.format ( 'Towers Builts: %d', self.vPlayerHeroData[i].nTowersBuilt))
		print ( string.format ( 'Player has a bank: %s', tostring(self.vPlayerHeroData[i].bHasBank)))
		print ( string.format ( 'Consumed Food: %d', self.vPlayerHeroData[i].nConsumedFood))
		print ( string.format ( 'Wood Remaining: %d', self.vPlayerHeroData[i].nTotalWood))
	end
end


function HeroWarsGameMode:_HWConsoleCommand()

	print( "********* HeroWars Game Status ********* " )
	--DeepPrintTable(self.vPlayerHeroData)
	for i = 1,#self.vPlayerHeroData do
		printTable( self.vPlayerHeroData[i], " " )
	end

	self:_debugPlayersInfo()

end

function HeroWarsGameMode:_DebugConsoleCommand()

	--self:UpdateTopScoreboard()
	--local nPlayerID = 0
	--self:UpdatePlayerFood(nPlayerID)
	--self:UpdatePlayerWood(nPlayerID)
	-- BASE_CLASSES = {"npc_dota_creature", "npc_dota_tower", "npc_dota_creep_lane", "npc_dota_creep_neutral", "npc_dota_creep_siege", "npc_dota_tusk_frozen_sigil", "npc_dota_elder_titan_ancestral_spirit", "npc_dota_creep", "npc_dota_courier", "npc_dota_flying_courier", "npc_dota_witch_doctor_death_ward", "npc_dota_shadowshaman_serpentward", "npc_dota_venomancer_plagueward", "npc_dota_invoker_forged_spirit", "npc_dota_broodmother_spiderling", "npc_dota_roshan", "npc_dota_warlock_golem", "npc_dota_beastmaster_hawk", "npc_dota_beastmaster_boar", "pc_dota_brewmaster_earth", "npc_dota_brewmaster_storm", "npc_dota_brewmaster_fire", "npc_dota_unit_undying_tombstone", "npc_dota_unit_undying_zombie", "npc_dota_rattletrap_cog", "npc_dota_earth_spirit_stone", "npc_dota_base"}
	-- if not self.InDuel then
	-- 	self.InDuel = true
	-- 	elseif self.InDuel then
	-- 		self.InDuel = false
	-- 	end

	-- for n = 1, #BASE_CLASSES do
	-- 	local allFoundEnts = Entities:FindAllByClassname(BASE_CLASSES[n])
	-- 	for i = 1, #allFoundEnts, 1 do
	-- 		local foundEnt = allFoundEnts[i]
	-- 		print (foundEnt:GetName())
	-- 		if self.InDuel == true then
	-- 			foundEnt:AddNewModifier(foundEnt, nil, 'modifier_greevil_time_lock_freeze', {})
	-- 		elseif self.InDuel == false then
	-- 			if foundEnt:HasModifier('modifier_greevil_time_lock_freeze') then
	-- 				foundEnt:RemoveModifierByName('modifier_greevil_time_lock_freeze')
	-- 			end
	-- 		end
	-- 	end
	-- end

	-- local prevEnt
	-- for i=1, #TOWERS_REMOVE_TS do 
	-- 	local towerName = TOWERS_REMOVE_TS[i]
	-- 	towerEnt = Entities:FindByName(prevEnt, towerName)
	-- 	--modifier_greevil_time_lock_freeze 
	-- 	--towerEnt:AddNewModifier(towerEnt, nil, 'modifier_halloween_truce', {})
	-- 	if self.InDuel == true then
	-- 		towerEnt:AddNewModifier(towerEnt, nil, 'modifier_greevil_time_lock_freeze', {})
	-- 	elseif self.InDuel == false then
	-- 		if towerEnt:HasModifier('modifier_greevil_time_lock_freeze') then
	-- 			towerEnt:RemoveModifierByName('modifier_greevil_time_lock_freeze')
	-- 		end
	-- 	end
	-- end

end

function HeroWarsGameMode:DisplayBuildingGrids()
  print( '******* Displaying Building Grids ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
		for vectString,b in pairs(BUILDING_SQUARES) do
			if b then
				local i = vectString:find(",")
				local x = tonumber(vectString:sub(1,i-1))
				local y = tonumber(vectString:sub(i+1))
				print("x: " .. x .. "y: " .. y)
				--PrintVector(square)
				BuildingHelper:PrintSquareFromCenterPoint(Vector(x,y,BH_Z))
			end
		end
    end
  end
  print( '*********************************************' )
end


--modifier_greevil_time_lock_freeze 

function HeroWarsGameMode:__EntityConsoleCommand()
	print("*** HWDEBUG: *** DEBUG *** Attempting to iterate over all entities ***")
	--attempt to iterate through all entities
	--not yet only if desperate
	local firstEnt = Entities:First()
	print (firstEnt:GetName())
	print (firstEnt)
	local nextEnt = Entities:Next(firstEnt)
	while nextExt ~= nil do
		print (nextEnt:GetName())
		print (nextEnt)
		nextEnt = Entities:Next(nextEnt)
	end

end


function HeroWarsGameMode:_EntityIdentifying()
	local myEnt = Entities:FindByClassname(nil, "env_global_light")
	print (myEnt)

end

	--first fine all the valid players, then loop through their owned buildings to find abilities to upgrade

	-- for i = 1,#self.vPlayerHeroData do
	-- 	if self.vPlayerHeroData[i].nPlayerTeam == 2 then
	-- 		--get the building slot
	-- 		local playerSlot = self.vPlayerHeroData[i].nRadiantPlayerSlot
	-- 		local brooderName = "Radiant_Brooder_Player" .. playerSlot
	-- 		print ("Testing" .. brooderName)
	-- 		local brooderEnt = Entities:FindByName( nil, brooderName )
	-- 		local brooderEntIdx = brooderEnt:GetEntityIndex()
	-- 		local brooder = EntIndexToHScript(brooderEntIdx)
	-- 		local ability1 = brooder:GetAbilityByIndex(0) -- this should be summon windigo/brats/hydras but lets check
	-- 		local abiName = ability1:GetAbilityName()
	-- 		if abiName == "summon_wave_windigo" then
	-- 			ability1:SetLevel(3) --works
	-- 		end

	-- 	end
	-- 	if self.vPlayerHeroData[i].nPlayerTeam == 3 then
	-- 		--get the building slot
	-- 		local playerSlot = self.vPlayerHeroData[i].nDirePlayerSlot
	-- 		local brooderName = "Dire_Brooder_Player" .. playerSlot
	-- 		print ("Testing" .. brooderName)
	-- 		local brooderEnt = Entities:FindByName( nil, brooderName )
	-- 		local brooderEntIdx = brooderEnt:GetEntityIndex()
	-- 		local brooder = EntIndexToHScript(brooderEntIdx)
	-- 		local ability1 = brooder:GetAbilityByIndex(0) -- this should be summon windigo/brats/hydras but lets check
	-- 		local abiName = ability1:GetAbilityName()
	-- 		if abiName == "summon_wave_windigo" then
	-- 			ability1:SetLevel(3) --works
	-- 		end
	-- 	end
	-- end