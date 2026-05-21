/// @self
/// @description				Retrieves the palette index for a given colour index palette.
/// @param {Real} _colour_index	The colour index.
/// @returns {Real}
function pal_get_index(_colour_index)
{
	if _colour_index >= PALETTE_TOTAL_SLOT_COUNT
	{
		return obj_game.palette_indices[PALETTE_TOTAL_SLOT_COUNT - 1];
	}
	
	return obj_game.palette_indices[_colour_index];
}