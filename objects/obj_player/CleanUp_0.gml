obj_game.player_count--;

if variable_instance_exists(id, "player_index")
{
	ds_list_destroy(recorded_data);
	
	with obj_player
	{
		if player_index > other.player_index
		{
			player_index--;
		}
	}
}