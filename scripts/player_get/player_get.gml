/// @self
/// @description				Retrieves the instance ID of a player object corresponding to the specified player index. Returns noone if no matching player object is found.
/// @param {Real} _player_index	The index of the player.
/// @returns {Id.Instance}
function player_get(_player_index)
{
	// If you plan to swap player indices, use the commented out code instead
	return instance_find(obj_player, _player_index);
	
	/*
	with obj_player
	{
		if _player_index == player_index
		{
			return id;
		}
	}
	
	return noone;
	*/
}