/// @self
/// @description				Sets the colour index for the given slots.
/// @param {Real} _entry		The palette entry identifier.
/// @param {Array<Real>} _slots	An array of slots to update.
/// @param {Real} _value		The colour index to set.
function pal_set_index(_entry, _slots, _index)
{
	var _map = obj_game.palette_maps[? _entry];
	
	if _map == undefined
	{
		return;
	}
	
	var _data = _map[0];
	var _count = array_length(_slots);
	
	for (var _i = 0; _i < _count; _i++)
	{
		var _slot = _slots[_i];
		
		if _slot < PALETTE_TOTAL_SLOT_COUNT
		{
			_data.timers[_slot] = _data.durations[_slot];
			_data.indices[_slot] = _index;
		}
	}
}