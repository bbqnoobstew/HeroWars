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

--print ("HWDEBUG: *** telepads started *** telepads.lua loaded")

--[[
Teleportation code.

Original Author - bbqnoobstew (njg)

]]

--for debugging, not used
function OnEndTouch(trigger)
	-- print "Teleport Triggered - OnEndTouch"

	-- print(trigger.activator)
	-- print(trigger.caller)
end

--[[
**** RADIANT ****
]]

--base to lane near mid
function RadiantBaseTeleportToNearMid(trigger)
	-- print "Radiant Base Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_radiant_lane_mid" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end

--base to lane near base
function RadiantBaseTeleportToNearBase(trigger)
	-- print "Radiant Base Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_radiant_lane_base" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end

--lane to base (only need one function)
function RadiantLaneTeleportToBase(trigger)
	-- print "Radiant Lane Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_radiant_base" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end



--[[
**** DIRE *****
]]

-- base to lane near mid
function DireBaseTeleportToNearMid(trigger)
	-- print "Dire Base Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_dire_lane_mid" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end

--base to lane near base
function DireBaseTeleportToNearBase(trigger)
	-- print "Radiant Base Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_dire_lane_base" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end

--lane near mid to base
function DireLaneTeleportToBase(trigger)
	-- print "Radiant Lane Teleport Triggered"
	-- print(trigger.activator)
	-- print(trigger.caller)

	-- Get the position of the "point_teleport_spot"-entity we put in our map
	local point =  Entities:FindByName( nil, "tp_dest_dire_base" ):GetAbsOrigin()
	-- Find a spot for the hero around 'point' and teleports to it
	FindClearSpaceForUnit(trigger.activator, point, false)
	-- Stop the hero, so he doesn't move
	trigger.activator:Stop()
	-- Refocus the camera of said player to the position of the teleported hero.
	SendToConsole("dota_camera_center")

end
