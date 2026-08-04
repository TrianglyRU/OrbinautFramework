/// @self
/// @description				Retrieves the colour index for a given slot.
/// @param {Real} _entry		The palette entry identifier.
/// @param {Real} _slot			A slot to retrieve the index from.
/// @returns {Real}
function pal_get_index(_entry, _slot)
{
	var _map = obj_game.palette_maps[? _entry];
	
	if _map == undefined
	{
		return 0;
	}
	
	var _data = _map[0];
	
	if _slot >= PALETTE_TOTAL_SLOT_COUNT
	{
		return _data.indices[PALETTE_TOTAL_SLOT_COUNT - 1];
	}
	
	return _data.indices[_slot];
}