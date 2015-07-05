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
Triggers file
Controls the various triggers that could be called by the map (trigger blocks)
Currently the only trigger is the trigger that kill players who attempt to cheat.
Original Author - bbqnoobstew (njg)
]]

--print ("HWDEBUG: *** triggers started *** triggers.lua loaded")


--base to lane near mid
function RadiantTrespasser(trigger)
	print "HWDEBUG:Radiant Trespass Trigger Fired!!"
	-- print(trigger.activator)
	-- print(trigger.caller)

    unitName = trigger.activator:GetUnitName() -- Retrieves the name that the unit has, such as listed in "npc_units_custom.txt"

	local name = trigger.activator:GetName()

	print ("HWDEBUG: Name = " .. name)
    print("HWDEBUG:Unit '" .. unitName .. "' has trespassed. Unit will be killed.")
	trigger.activator:ForceKill(true) -- Kills the unit
	--TODO: Make this display something better than 'npc_dota_hero_queenofpain'
	GameRules:SendCustomMessage("<font color='#FF3333' face='Dota Hypatia Bold'><b> " .. unitName .. " was caught trespassing and put to death!</b></font>", 0, 0)

end

function DireTrespasser(trigger)
	print "HWDEBUG:Dire Trespass Trigger Fired!!"
	-- print(trigger.activator)
	-- print(trigger.caller)

    unitName = trigger.activator:GetUnitName() -- Retrieves the name that the unit has, such as listed in "npc_units_custom.txt"
	local name = trigger.activator:GetName()

	print ("HWDEBUG: Name = " .. name)
    print("HWDEBUG:Unit '" .. unitName .. "' has trespassed. Unit will be killed.")
	trigger.activator:ForceKill(true) -- Kills the unit
	--TODO: Make this display something better than 'npc_dota_hero_queenofpain'
	GameRules:SendCustomMessage("<font color='#FF3333' face='Dota Hypatia Bold'><b> " .. unitName .. " was caught trespassing and put to death!</b></font>", 0, 0)

end