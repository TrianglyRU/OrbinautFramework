/// @self
/// @description Spawns a player object of the given type (character) at the specified location. Returns the instance ID of the created player, or `noone` if the maximum player count is exceeded.
/// @param {Real} x The x-coordinate of the spawn location.
/// @param {Real} y The y-coordinate of the spawn location.
/// @param {Constant} player_type The character to spawn.
/// @param {String} layer The name of the layer where the player object will be placed.
/// @returns {Id.Instance}
function player_spawn(_x, _y, _player_type, _layer)
{
	if PLAYER_COUNT > ENGINE_PLAYER_MAX_COUNT
	{
		return noone;
	}
	
	return instance_create(_x, _y, obj_player,
	{
		PlayerType: _player_type, depth: layer_get_depth(_layer)
	});
}