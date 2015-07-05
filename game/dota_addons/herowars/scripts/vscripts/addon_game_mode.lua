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
This is the file provided by Valve as the main entry point in to the custom game.
This file precaches all the models and sounds, adds a util method, and then finally directs the Activate() callback to HeroWarsGameMode
Original Author - bbqnoobstew (njg)
]]

print "[HERO WARS] addon_game_mode.lua loaded"

require('utils/telepads')
require('utils/timers')
require('utils/triggers')
require('utils/popups')
require('custom_abilities/custom_abilities')
require('custom_items/custom_items')
require('herowars')


function Precache( context )
--[[
This function is used to precache resources/units/items/abilities that will be needed
for sure in your game and that cannot or should not be precached asynchronously or 
after the game loads.

See GameMode:PostLoadPrecache() in barebones.lua for more information
]]

	--print("HWDEBUG: Performing pre-load precache")

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	PrecacheResource("particle_folder", "particles/test_particle", context)

	-- my particles
	
	PrecacheResource("particle", "particles/base_attacks/ranged_siege_bad.vpcf", context)
	
	-- archer reinforcements particles
	PrecacheResource("particle", "particles/base_attacks/ranged_goodguy.vpcf", context)

	--watch tower particles
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_base_attack.vpcf", context)

	-- blood dumpster attack particle
	PrecacheResource("particle", "particles/units/heroes/hero_huskar_temp/huskar_base_attack.vpcf", context)

	--snow cone maker/the slower
	PrecacheResource("particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_base_attack.vpcf", context)

	--destroyer
	PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_base_attack.vpcf", context)

	--the slower
	PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_base_attack.vpcf", context)

	--adv long ranged tower
	PrecacheResource("particle", "particles/units/heroes/hero_death_prophet/death_prophet_base_attack.vpcf", context)

	--particle for blizzard
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_frost_lich.vpcf", context)

	--particles/sounds for chain lightning
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)

	--particles/sounds for death coil
	PrecacheResource("particle", "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf", context)

	--war stomp
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context)

	--other castable spells not named
	PrecacheResource("particle", "particles/items_fx/black_king_bar_avatar.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/cyclone.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_siren/siren_net_projectile_launch.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_siren/siren_net.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_brewmaster/brewmaster_hurl_boulder.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_brewmaster/brewmaster_hurl_boulder_explode.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf", context)
	PrecacheResource("particle", "particles/generic_hero_status/status_invisibility_start.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration_heal.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_sleep.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_storm_bolt_projectile_explosion.vpcf", context)

	PrecacheResource("particle", "particles/generic_gameplay/generic_stunned.vpcf", context)

	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_laguna_blade_impact_fire.vpcf", context)

	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_overgrowth_vine_glows_corerope.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_mana_leak_cast.vpcf", context)

	PrecacheModel("models/props_gameplay/frog.vmdl", context)

	PrecacheModel("models/props_gameplay/default_ward.vmdl", context)

	--sounds for abilities
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_batrider.vsndevts", context)




	--misc not used
	PrecacheResource("particle", "particles/neutral_fx/gnoll_base_attack.vpcf", context)
	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	PrecacheResource("model_folder", "particles/heroes/antimage", context)
	PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	PrecacheModel("models/heroes/viper/viper.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	-- PrecacheItemByNameSync("example_ability", context)
	-- PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync("npc_dota_hero_enigma", context)

	-- *** MINE ***

	-- *** BUILDINGS ***
	--buildings
	PrecacheUnitByNameSync("npc_dota_town_hall", context) --not in use currently
	PrecacheModel( "models/props_structures/good_barracks_melee001.vmdl", context) --not in use any more

	--barracks/brooder/armory - all use same model
	PrecacheUnitByNameSync("npc_dota_building_barracks", context)
	PrecacheUnitByNameSync("npc_dota_building_brooder", context)
	PrecacheUnitByNameSync("npc_dota_building_armory", context)

	PrecacheModel( "models/props_structures/tent_dk_med.vmdl", context)

	--bank
	PrecacheUnitByNameSync("npc_dota_player_bank", context)
	PrecacheModel( "models/props_structures/statue_dragon001.vmdl", context) -- the player bank


	-- *** UNITS ***

	-- precache all the base lane creep units - dont have models figured out yet so that will have to be inserted
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlone", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvltwo", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlthree", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlfour", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlfive", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlsix", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlseven", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvleight", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlnine", context)
	PrecacheUnitByNameSync("npc_dota_creep_dire_lvlten", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlone", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvltwo", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlthree", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlfour", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlfive", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlsix", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlseven", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvleight", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlnine", context)
	PrecacheUnitByNameSync("npc_dota_creep_radiant_lvlten", context)

	--round four extra unit
	PrecacheUnitByNameSync("npc_dota_golem_radiant_roundfour", context)
	PrecacheUnitByNameSync("npc_dota_golem_dire_roundfour", context)
	
	--base lane creep models
	--dire
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context) --dire creep wave lvl 1
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_ghost_b/n_creep_ghost_b.vmdl", context) --dire creep wave lvl 2
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_gargoyle/n_creep_gargoyle.vmdl", context) --dire creep wave lvl 3
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_worg_small/n_creep_worg_small.vmdl", context) --dire creep wave lvl 4
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_worg_large/n_creep_worg_large.vmdl", context) --dire creep wave lvl 5
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context) --dire creep wave lvl 6
	PrecacheModel( "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega.vmdl", context) --dire creep wave lvl 7
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_troll_dark_a/n_creep_troll_dark_a.vmdl", context) --dire creep wave lvl 8
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_satyr_b/n_creep_satyr_b.vmdl", context) --dire creep wave lvl 9
	PrecacheModel( "models/heroes/invoker/forge_spirit.vmdl", context) --dire creep wave lvl 10

	--radiant
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_kobold/kobold_c/n_creep_kobold_c.vmdl", context) --radiant creep wave lvl 1
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_kobold/kobold_b/n_creep_kobold_b.vmdl", context) --radiant creep wave lvl 2
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_centaur_med/n_creep_centaur_med.vmdl", context) --radiant creep wave lvl 3
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_centaur_lrg/n_creep_centaur_lrg.vmdl", context) --radiant creep wave lvl 4
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_vulture_b/n_creep_vulture_b.vmdl", context) --radiant creep wave lvl 5
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_vulture_a/n_creep_vulture_a.vmdl", context) --radiant creep wave lvl 6
	PrecacheModel( "models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mega.vmdl", context) --dire creep wave lvl 7
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_berserker.vmdl", context) --radiant creep wave lvl 8
	--PrecacheModel( "models/creeps/neutral_creeps/n_creeps_forest_troll/n_creep_forest_troll_high_priest.vmdl", context) --radiant creep wave lvl 9
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_harpy_b/n_creep_harpy_b.vmdl", context) --radiant creep wave lvl 9
	PrecacheModel( "models/creeps/lane_creeps/creep_good_ranged/creep_good_ranged.vmdl", context) --radiant creep wave lvl 10

	--round 4 extra spawn
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_golem_b/n_creep_golem_b.vmdl", context) --mini mech round 4


	--summonable wave models
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_satyr_a/n_creep_satyr_a.vmdl", context) --windigo
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_satyr_c/n_creep_satyr_c.vmdl", context) --windigo brat
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_furbolg/n_creep_furbolg_disrupter.vmdl", context) --destructor wave
	PrecacheModel( "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged.vmdl", context) -- dire archer reinforcements (same model for invis assassins)
	PrecacheModel( "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged.vmdl", context) -- radiant archer reinforcements (same model for invis assassins)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context) --hydras

	--summonable wave units
	PrecacheUnitByNameSync("npc_dota_wave_windigo", context) --windigo
	PrecacheUnitByNameSync("npc_dota_wave_windigo_brat", context) --windigo brat
	PrecacheUnitByNameSync("npc_dota_wave_hydralisk", context) --hydralisks (hydras)

	--summonable archer reinforcements units
	PrecacheUnitByNameSync("npc_dota_wave_archer_reinforcements_lvlone", context)
	PrecacheUnitByNameSync("npc_dota_wave_archer_reinforcements_lvltwo", context)
	PrecacheUnitByNameSync("npc_dota_wave_archer_reinforcements_lvlthree", context)

	--summonable archer reinforcements models
	PrecacheModel( "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged.vmdl", context)

	--[[
		*** trainable controlled units ***
	]]

	--the peons
	PrecacheUnitByNameSync("npc_dota_unit_peon", context) --peon
	PrecacheUnitByNameSync("npc_dota_unit_master_peon", context) --master peon
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_ogre_med/n_creep_ogre_med.vmdl", context) --peon and master peon

	--mortar team/bomb squad
	PrecacheUnitByNameSync( "npc_dota_unit_mortar_team", context)
	PrecacheModel( "models/npc_minions/draft_siege_good.vmdl", context)
	PrecacheUnitByNameSync( "npc_dota_unit_bomb_squad", context)
	PrecacheModel( "models/npc_minions/draft_siege_evil.vmdl", context)

	--mech warrior
	PrecacheUnitByNameSync( "npc_dota_unit_mech_warrior", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl", context)

	--superior archer
	PrecacheUnitByNameSync( "npc_dota_unit_sup_archer", context)
	PrecacheModel( "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged.vmdl", context)

	--PrecacheModel( "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl", context) --summonable mech
	--PrecacheModel( "models/npc_minions/draft_siege_good.vmdl", context) --mortar team
	--PrecacheModel( "models/npc_minions/draft_siege_evil.vmdl", context) --bomb squad
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_high_priest.vmdl", context) --priest
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_kobold/kobold_a/n_creep_kobold_a.vmdl", context) --handyman
	

	--sort this out (can be deleted i'm 99 percent sure)
	PrecacheUnitByNameSync("npc_dota_creature_gnoll_assassin", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_gnoll/n_creep_gnoll_frost.vmdl", context) --for testing



	--[[
		*** TOWERS ***
	]]
	PrecacheUnitByNameSync("npc_dota_tower_dragon_white", context)
	PrecacheUnitByNameSync("npc_dota_tower_dragon_black", context)

	PrecacheModel( "models/props_structures/tower_dragon_white.vmdl", context)
	PrecacheModel( "models/props_structures/tower_dragon_black.vmdl", context)

	--watch and guard towers
	PrecacheUnitByNameSync( "npc_dota_tower_watch_tower_lvlone", context)
	PrecacheUnitByNameSync( "npc_dota_tower_watch_tower_lvltwo", context)
	PrecacheUnitByNameSync( "npc_dota_tower_watch_tower_lvlthree", context)
	PrecacheUnitByNameSync( "npc_dota_tower_watch_tower_lvlfour", context)
	PrecacheModel( "models/props_structures/tower_good.vmdl", context)
	
	PrecacheUnitByNameSync( "npc_dota_tower_cannon_tower_lvlone", context)
	PrecacheUnitByNameSync( "npc_dota_tower_cannon_tower_lvltwo", context)
	PrecacheUnitByNameSync( "npc_dota_tower_cannon_tower_lvlfour", context)
	PrecacheModel( "models/props_structures/tower_good3.vmdl", context)

	--anti invis
	PrecacheUnitByNameSync( "npc_dota_tower_anti_invis", context)
	PrecacheModel( "models/props_structures/wooden_sentry_tower001.vmdl", context)

	--blood dumpster (particles are above in my particles section)
	PrecacheUnitByNameSync( "npc_dota_tower_blood_dumpster", context)
	PrecacheModel( "models/props_structures/tower_dragon_black.vmdl", context)

	--snowcone maker
	PrecacheUnitByNameSync( "npc_dota_tower_snowcone_maker", context)
	PrecacheModel( "models/props_structures/bad_statue001.vmdl", context)

	--The Destroyer
	PrecacheUnitByNameSync( "npc_dota_tower_destroyer", context)
	PrecacheModel( "models/props_structures/tower_bad.vmdl", context)

	--the slower
	PrecacheUnitByNameSync( "npc_dota_tower_slower", context)
	PrecacheModel( "models/props_structures/bad_statue002.vmdl", context)

	--long ranged tower
	PrecacheUnitByNameSync( "npc_dota_tower_longrange", context)
	PrecacheModel( "models/creeps/lane_creeps/creep_good_siege/creep_good_siege.vmdl", context)

	--adv long ranged tower
	PrecacheUnitByNameSync( "npc_dota_tower_advlongrange", context)
	PrecacheModel( "models/creeps/lane_creeps/creep_bad_siege/creep_bad_siege.vmdl", context)

	--[[
		*** FARMS ***		
	]]

	PrecacheUnitByNameSync( "npc_dota_fort_dire_farm", context)
	PrecacheModel( "models/buildings/building_racks_melee_reference.vmdl", context)
	PrecacheUnitByNameSync( "npc_dota_fort_radiant_farm", context)
	PrecacheModel( "models/buildings/building_racks_ranged_reference.vmdl", context)

	--[[
		*** DUMMY UNITS ***
	]]

	PrecacheUnitByNameSync( "dummy_unit", context)
	PrecacheUnitByNameSync( "dummy_unit_vulnerable", context)

	--[[
		*** LEGACY ***
	]]
	-- extra lane creep spawns
	PrecacheUnitByNameSync("npc_dota_jungle_stalker", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_gargoyle/n_creep_gargoyle.vmdl", context)

	PrecacheUnitByNameSync("npc_dota_harpy_storm", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_harpy_b/n_creep_harpy_b.vmdl", context)

	PrecacheUnitByNameSync("npc_dota_furbolg", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_beast/n_creep_beast.vmdl", context)

	PrecacheUnitByNameSync("npc_dota_forest_troll_berserker", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_berserker.vmdl", context)

	--special creep wave spawns
	PrecacheUnitByNameSync("npc_dota_furbolg_champion", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_furbolg/n_creep_furbolg_disrupter.vmdl", context)

	PrecacheUnitByNameSync("npc_dota_black_dragon", context)
	PrecacheModel( "models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context)

	--old
	PrecacheModel( "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee.vmdl", context)
	--PrecacheModel( "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged.vmdl", context)
	PrecacheModel( "models/creeps/lane_creeps/creep_radiant_melee/radiant_melee.vmdl", context)
	PrecacheModel( "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged.vmdl", context)
end


function Dynamic_Wrap( mt, name )
--[[
Neat little utils function that wraps the 'name' of a function and returns the metatable value for that name
e.g.
ListenToGameEvent('player_connect_full', Dynamic_Wrap(HeroWarsGameMode, 'onPlayerLoaded'), self)
]]
	return mt[name]
end

--Create the game mode when we activate
function Activate()
	--print("HWDEBUG: Activate inside addon_game_mode.lua fired!")
	GameRules.HeroWarsGameMode = HeroWarsGameMode()
	GameRules.HeroWarsGameMode:InitGameMode()
end