/// @self
/// @description Retrieves the instance ID of a player object corresponding to the specified player index. Returns `noone` if no matching player object is found.
/// @param {Real} player_index The index of the player.
/// @returns {Id.Instance}
function player_get(_player_index)
{
	return instance_find(obj_player, _player_index);
}
