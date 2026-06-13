/// @self obj_player
function scr_player_debug_mode()
{
	if input_down.up || input_down.down || input_down.left || input_down.right
	{
	    debug_mode_spd = min(debug_mode_spd + 0.046875, 16);
		
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
		
		x = clamp(x, view_data_ref.left_bound, view_data_ref.right_bound - 1);
		y = clamp(y, view_data_ref.top_bound, view_data_ref.bottom_bound - 1);
	}
	else
	{
	    debug_mode_spd = 0;
	}

	var _max_index = array_length(debug_mode_array) - 1;
	
	if input_press.action1
	{
	    if (++debug_mode_ind > _max_index)
	    {
	        debug_mode_ind = 0;
	    }
	}
	else if input_press.action3
	{
	    if input_down.action1
	    {
	        if --debug_mode_ind < 0
	        {
	            debug_mode_ind = _max_index;
	        }
	    }
	    else
	    {
			with instance_create(x, y, debug_mode_array[debug_mode_ind], { image_xscale: facing })
			{
				if culler != noone
				{
					culler.action = CULL_ACTION.DESTROY;
				}
			}
	    }
	}
	else if input_press.action2
	{
	    state = PLAYER_STATE.DEFAULT;
	    animation = ANIM.MOVE;
	    is_underwater = false;
	    debug_mode_spd = 0;
	    spd = 0;
	    vel_x = 0;
	    vel_y = 0;
		reset_gravity();
		
		x = floor(x);
		y = floor(y);
	}
}