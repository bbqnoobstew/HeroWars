$.Msg( "[HERO WARS] UpdateTopScoreboard.js loaded" );

function UpdateTeamScores( event_data )
{
	/* $.Msg( "OnMyEvent: ", event_data ); */
	$( "#RadiantScore" ).text = event_data['radiantScore'];
	$( "#DireScore" ).text = event_data['direScore'];
}

GameEvents.Subscribe( "update_team_scores", UpdateTeamScores);