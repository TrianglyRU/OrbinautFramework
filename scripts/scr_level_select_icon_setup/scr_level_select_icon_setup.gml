/// @self obj_level_select_icon
function scr_level_select_icon_setup()
{
	var _data =
	[
		rm_special,		2,
		rm_bonus,	    3,
		rm_stage_ghz_1, 4,
		rm_stage_ehz_1, 5,
		rm_stage_tsz,   6
	];
	
	var _length = array_length(_data);
	
	for (var _i = 0; _i < _length - 1; _i += 2)
	{
		ds_map_add(icon_map, _data[_i], _data[_i + 1]);
	}
}