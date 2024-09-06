/// @self
/// @description Clears temporary game data, such as ring count, current shield, and life rewards.
/// @param {Bool} [full_clear] If true, also clears saved positions and collected giant rings (optional, defaults to true).
function game_clear_temp_data(_full_clear = true)
{
	if _full_clear
	{
		global.checkpoint_data = [];
		global.giant_ring_data = [];
		ds_list_clear(global.ds_giant_rings);
	}
	
	for (var i = 0; i < ENGINE_PLAYER_MAX_COUNT; i++)
	{
		global.player_shield[i] = SHIELD_NONE;
	}
	
	global.player_rings = 0;
	global.life_rewards = [];
}