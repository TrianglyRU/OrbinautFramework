/// @function scr_player_debug_mode
function scr_player_debug_mode()
{
	gml_pragma("forceinline");
	
	if input_down.up || input_down.down || input_down.left || input_down.right
	{
	    debug_mode_spd = min(debug_mode_spd + (global.dev_mode ? 0.1875 : 0.046875), 16);
    
	    // Adjust position based on input direction
	    if input_down.up
	    {
	        y -= debug_mode_spd;
	    }
	    if input_down.down
	    {
	        y += debug_mode_spd;
	    }
	    if input_down.left
	    {
	        x -= debug_mode_spd;
		}
	    if input_down.right
	    {
	        x += debug_mode_spd;
	    }
		
		x = clamp(x, camera_data.min_x, camera_data.max_x - 1);
		y = clamp(y, camera_data.min_y, camera_data.max_y - 1);
	}
	else
	{
	    debug_mode_spd = 0;
	}

	var _debug_button = input_press.action2;
	
	if global.dev_mode
	{
	    _debug_button = keyboard_check_pressed(vk_space);
		
	    var _pads_array = c_framework.input.pads_array;
		
	    if array_length(_pads_array) > 0
	    {
	        _debug_button |= gamepad_button_check_pressed(_pads_array[0], gp_face3);
	    }
	}

	// Handle debug mode switching and object creation
	var _max_ind = array_length(debug_mode_array) - 1;

	if input_press.action1
	{
	    // Cycle through objects
	    if ++debug_mode_ind > _max_ind
	    {
	        debug_mode_ind = 0;
	    }
	}
	else if input_press.action3
	{
	    if input_down.action1
	    {
	        // Reverse cycle through objects
	        if --debug_mode_ind < 0
	        {
	            debug_mode_ind = _max_ind;
	        }
	    }
	    else
	    {
	        // Create a new object
	        with instance_create(x, y, debug_mode_array[debug_mode_ind], { image_xscale: facing, depth: data_culling.priority })
	        {
	            obj_set_culling(CULLING.REMOVE);
	        }
	    }
	}
	else if _debug_button
	{
	    if c_framework.state == STATE_STOP_OBJECTS
	    {
	        c_framework.state = STATE_NORMAL;
	    }
		
	    state = PLAYER_STATE_CONTROL;
	    animation = ANI_MOVE;
	    air_lock_flag = false;
	    is_underwater = false;
	    debug_mode_spd = 0;
	    spd_ground = 0;
	    vel_x = 0;
	    vel_y = 0;
		
		// Clear subpixel position
		x = floor(x);
		y = floor(y);
		
	    m_player_reset_gravity();
	    m_player_reset();
	    obj_reset_priority();
	}
}