/// @self obj_player()
function scr_player_flight()
{
	if action != ACTION.FLIGHT
	{
	    return;
	}
	
	if flight_timer > 0
	{
	    flight_timer--;
	}
	
	if ascend_timer > 0
	{
	    if vel_y >= -1
	    {
	        grv = PARAM_GRV_TAILS_UP;
			
	        if ++ascend_timer == 31
	        {
	            ascend_timer = 0;
	        }
	    }
	    else
	    {
	        ascend_timer = 0;
	    }
	}
	else
	{
	    if flight_timer > 0 && (!is_underwater || carry_target == noone) && input_press_action_any()
	    {
	        ascend_timer = 1;
	    }
		
	    grv = PARAM_GRV_TAILS_DOWN;
	}
    
	play_tails_sound();
	
	if is_underwater
	{
	    animation = flight_timer > 0 ? ANIM.SWIM : ANIM.SWIM_TIRED;
	}
	else
	{
	    animation = flight_timer > 0 ? ANIM.FLY : ANIM.FLY_TIRED;    
	}
}