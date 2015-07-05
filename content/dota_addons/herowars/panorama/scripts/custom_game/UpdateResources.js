$.Msg( "[HERO WARS] UpdateResources.js loaded" );

/*(function () {
	$( "#FoodValueText" ).text = "hello";
	$.Msg( "The panel associated with this javascript just got loaded or reloaded!" );
	//Get the details for hte local player
	//{"player_id":0,"player_name":"bbqnoobstew","player_connection_state":2,"player_steamid":"76561197984608384","player_kills":0,"player_deaths":0,"player_assists":0,"player_selected_hero_id":101,"player_selected_hero":"npc_dota_hero_skywrath_mage","possible_hero_selection":"abaddon","player_level":1,"player_respawn_seconds":-1,"player_gold":23093,"player_team_id":2,"player_is_local":true,"player_has_host_privileges":true}
	var localPlayer = Game.GetLocalPlayerInfo();
	$.Msg(localPlayer);
	//GameEvents.Subscribe( "my_event_name", OnMyEvent);

})();*/

function UpdatePlayerFood( event_data )
{
	/*$.Msg( "OnMyEvent: ", event_data ); */
	$( "#FoodValueText" ).text = event_data['foodValue'];
}

function UpdatePlayerWood( event_data )
{
	/* $.Msg( "OnMyEvent: ", event_data );*/
	$( "#WoodValueText" ).text = event_data['woodValue'];
}

GameEvents.Subscribe( "update_player_food", UpdatePlayerFood);
GameEvents.Subscribe( "update_player_wood", UpdatePlayerWood);