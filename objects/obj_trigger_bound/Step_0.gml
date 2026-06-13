visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

FOR_EACH_VISIBLE_VIEW
{
	var _w = camera_get_width(_v);
	var _h = camera_get_height(_v);
	
	var _view_data = view_data[_v];
	var _x = _view_data.raw_x + _w * 0.5;
	var _y = _view_data.raw_y + _h * 0.5;
	
	_x = floor(_x);
	_y = floor(_y);
	
	if point_in_rectangle(_x, _y, bbox_left, btop, bbox_right - 1, bbottom)
	{
		if sign(image_yscale) >= 0
		{
			obj_rm_stage.bottom_bound[_v] = max(y, _h);
			
			if iv_speed == 0
			{
				_view_data.bottom_bound = obj_rm_stage.bottom_bound[_v];
			}
			else
			{
				obj_rm_stage.camera_bound_speed[_v] = iv_speed;
			}
		}
		else
		{
			obj_rm_stage.top_bound[_v] = min(y, room_height - _h);
			
			if iv_speed == 0
			{
				_view_data.top_bound = obj_rm_stage.top_bound[_v];
			}
			else
			{
				obj_rm_stage.camera_bound_speed[_v] = iv_speed;
			}
		}
	}
}