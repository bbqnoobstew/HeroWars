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
Original Author - bbqnoobstew (njg)
Archer Assassin Hunter/Seeker
]]

require('utils/timers')

function Spawn( entityKeyValues )
	Timers:CreateTimer(0,AAThink)
end

function AAThink()
	--print("HWDEBUG: AA is thinking...")
	--Dont think if the entity is dead
	if not thisEntity:IsAlive() then
		return nil
	end
	
	--if the entity has no target
	if thisEntity:GetAttackTarget() == nil then
		--find all heroes in a radius, returning the list with the closest first.
		local units = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), thisEntity, 1400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
		if units ~= nil then
			if #units > 0 then
				for i=1,#units do
					if not units[i]:IsAttackImmune() then
						--print("AI found NEW target: " .. units[i]:GetUnitName())
						thisEntity:SetForceAttackTarget(units[i])
						break
					end
				end
			end
			--here
		end
	else
		--print("AI has an EXISTING attack target of: " .. thisEntity:GetAttackTarget():GetUnitName())
	end

	--1 to 1.5
	return 0.25 + RandomFloat( 0.25, 0.5 )
end