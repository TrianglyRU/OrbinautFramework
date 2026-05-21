/// @self
/// @description Clears restart-sensitive level-specific data, such as ring count, player shields and life rewards.
function game_clear_level_data()
{
	for (var _i = array_length(global.player_shields) - 1; _i >= 0; _i--)
	{
		global.player_shields[_i] = SHIELD.NONE;
	}
	
	global.player_rings = 0;
	global.life_rewards =
	[
		RINGS_THRESHOLD, 
		floor(global.score_count / SCORE_THRESHOLD) * SCORE_THRESHOLD + SCORE_THRESHOLD
	];
}