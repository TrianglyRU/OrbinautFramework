visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

if !instance_exists(obj_water)
{
	return;
}

FOR_EACH_VISIBLE_VIEW
{
	var _w = camera_get_width(_v);
	var _h = camera_get_height(_v);
	
	var _view_data = view_data[_v];
	var _x = _view_data.raw_x + _w * 0.5;
	var _y = _view_data.raw_y + _h * 0.5;
		
	if !point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
	{
		continue;
	}
	
	if iv_velocity == 0
	{
		obj_water.current_level = iv_target_level;
		obj_water.target_level = iv_target_level;
	}
	else
	{
		obj_water.target_level = iv_target_level;
		obj_water.velocity = abs(iv_velocity);
	}
}