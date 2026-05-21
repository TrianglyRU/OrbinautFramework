/// @self
/// @description							Stops the palette rotation for the given colour indices.
/// @param {Array<Real>} _colour_indices	An array of colour indices stop the rotation for.
function pal_stop_rotation(_colour_indices)
{
	var _durations = obj_game.palette_durations;
	
	for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
	{
		var _index = _colour_indices[_i];
		
		if _index < PALETTE_TOTAL_SLOT_COUNT
		{
			_durations[_index] = 0;
		}
	}
}