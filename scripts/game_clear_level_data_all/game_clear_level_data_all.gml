/// @self
/// @description Clears all level-specific data, including saved positions and collected giant rings.
function game_clear_level_data_all()
{
	global.checkpoint_data = [];
	global.giant_ring_data = [];
	
	game_clear_level_data();
}