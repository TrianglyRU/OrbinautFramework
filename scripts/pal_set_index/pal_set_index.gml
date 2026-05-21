/// @self
/// @description							Sets the palette index for the given colour indices.
/// @param {Array<Real>} _colour_indices	An array of colour indices to modify.
/// @param {Real} _replacement_index		The new palette index.
function pal_set_index(_colour_indices, _replacement_index)
{
	var _timers = obj_game.palette_timers;
	var _durations = obj_game.palette_durations;
	var _indices = obj_game.palette_indices;
	
	for (var _i = array_length(_colour_indices) - 1; _i >= 0; _i--)
	{
		var _index = _colour_indices[_i];
		
		if _index < PALETTE_TOTAL_SLOT_COUNT
		{
			_timers[_index] = _durations[_index];
			_indices[_index] = _replacement_index;
		}
	}
}