/// @self
/// @description						Stops the palette rotation for the given slots.
/// @param {Real} _entry				The palette entry identifier.
/// @param {Array<Real>} _slots			An array of slots to stop the rotation for.
/// @param {Real|Undefined} [_value]	The colour index to set (default is undefined).
function pal_stop_rotation(_entry, _slots, _index = undefined)
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
			_data.durations[_slot] = 0;
			_data.timers[_slot] = 0;
			
			if _index != undefined
			{
				_data.indices[_slot] = _index;
			}
		}
	}
}