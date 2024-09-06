/// @self
/// @description Sets the rotation parameters for one or more colour IDs, enabling them to cycle through the palette over a specified duration.
/// @param {Array<Real>} col_ids An array of colour IDs for which the rotation parameters are to be set.
/// @param {Real} loop_index The index within the palette to which the rotation will loop back after it ends.
/// @param {Real} end_index The ending index within the palette loop where the rotation ends.
/// @param {Real} duration The duration of each frame in the colour rotation sequence, in game steps.
function pal_run_rotation(_col_ids, _loop_index, _end_index, _duration)
{
	var _palette = c_framework.palette;	
	
	for (var i = array_length(_col_ids) - 1; i >= 0; i--)
	{
		var _col_id = _col_ids[i];

		ds_list_add(_palette.ds_colours, _col_id);

		if _palette.duration[_col_id] != _duration
		{
			_palette.timer[_col_id] = _duration;
		}

		_palette.loop_index[_col_id] = _loop_index;
		_palette.end_index[_col_id] = _end_index;
		_palette.duration[_col_id] = _duration;
	}
}