/// @self
/// @description Sets the palette index for one or more colour IDs, and optionally stops their colour rotation.
/// @param {Array<Real>} col_ids An array of colour ID(s) for which to set the palette index.
/// @param {Real} index The palette index.
/// @param {Bool} [stop_rotation] If true, stops the rotation (optional, defaults to false).
function pal_set_index(_col_ids, _index, _stop_rotation = false)
{ 
	var _palette = c_framework.palette;
	
	for (var i = array_length(_col_ids) - 1; i >= 0; i--)
	{
		var _col = _col_ids[i];

		ds_list_add(_palette.ds_colours, _col);

		if _stop_rotation
		{
			_palette.duration[_col] = 0;
		}
		else
		{
			_palette.timer[_col] = _palette.duration[_col];
			_palette.index[_col] = _index;
		}
	}
}