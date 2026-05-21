visible = player_get(0).state == PLAYER_STATE.DEBUG_MODE;

FOR_EACH_CAMERA
{
	var _camera = view_data[_c];
	
	if _camera == undefined
	{
		continue;
	}
	
	var _w = camera_get_width(_c);
	var _h = camera_get_height(_c);
	
	var _x = _camera.raw_x + _w * 0.5;
	var _y = _camera.raw_y + _h * 0.5;
	
	_x = floor(_x);
	_y = floor(_y);
	
	if point_in_rectangle(_x, _y, bbox_left, btop, bbox_right - 1, bbottom)
	{
		if sign(image_yscale) >= 0
		{
			obj_rm_stage.bottom_bound[_c] = max(y, _h);
			
			if iv_speed == 0
			{
				_camera.bottom_bound = obj_rm_stage.bottom_bound[_c];
			}
			else
			{
				obj_rm_stage.camera_bound_speed[_c] = iv_speed;
			}
		}
		else
		{
			obj_rm_stage.top_bound[_c] = min(y, room_height - _h);
			
			if iv_speed == 0
			{
				_camera.top_bound = obj_rm_stage.top_bound[_c];
			}
			else
			{
				obj_rm_stage.camera_bound_speed[_c] = iv_speed;
			}
		}
	}
}