visible = global.debug_collision > 0;

for (var i = 0; i < CAMERA_COUNT; i++)
{
	var _camera = camera_get_data(i);
	
	if _camera == noone
	{
		continue;
	}
	
	var _half_width = camera_get_width(i) / 2;
	var _half_height = camera_get_height(i) / 2;
	
	var _y = _camera.pos_y + _half_height;
	
	// Check if camera's vertical position is within the vertical bounds
	if _y < bbox_top || _y >= bbox_bottom
	{
		continue;
	}
	
	var _x = _camera.pos_x + _half_width;
	var _x_prev = _camera.pos_x_prev + _half_width;
	
	// Check for horizontal crossing of the object
	if image_xscale > 0 && _x >= x && _x_prev < x || image_xscale < 0 && _x < x && _x_prev >= x
	{
		c_stage.bound_bottom[i] = BottomLimit;
		c_stage.bound_top[i] = TopLimit;
		c_stage.bound_speed[i] = Speed;
	}
}