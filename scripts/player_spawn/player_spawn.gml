/// @self
/// @description						Spawns a player object of the given type at the specified location. Returns the instance ID of the created player, or noone if the maximum player count is exceeded.
/// @param {Real} _x					The x-coordinate of the spawn location.
/// @param {Real} _y					The y-coordinate of the spawn location.
/// @param {Enum.PLAYER} _player_type	The character to spawn.
/// @param {Real} [_depth]				The depth the player object will be drawn with (default is the depth of the calling instance).
/// @returns {Id.Instance}
function player_spawn(_x, _y, _player_type, _depth = depth)
{
	if PLAYER_COUNT > PLAYER_MAX_COUNT
	{
		return noone;
	}
	
	return instance_create(_x, _y, obj_player, { player_type: _player_type, depth: _depth });
}