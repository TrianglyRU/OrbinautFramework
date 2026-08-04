/// @self
/// @description							Registers the palette rotation for the given slots.
/// @param {Real} _entry					The palette entry identifier.
/// @param {Array<Real>} _slots				An array of slots to update.
/// @param {Real} _duration					The duration per one colour index, in game steps.
/// @param {Real} _loop_index				The colour index to loop back to.
/// @param {Real} _end_index				The ending colour index.
/// @param {Real|Undefined} [_index]		The colour index to set (default is undefined).
function pal_set_rotation(_entry, _slots, _duration, _loop_index, _end_index, _index)
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
			if _data.durations[_slot] != _duration
			{
				_data.timers[_slot] = _duration;
			}
			
			_data.loop_indices[_slot] = _loop_index;
			_data.end_indices[_slot] = _end_index;
			_data.durations[_slot] = _duration;
			
			if _index != undefined
			{
				_data.indices[_slot] = _index;
			}
		}
	}
}