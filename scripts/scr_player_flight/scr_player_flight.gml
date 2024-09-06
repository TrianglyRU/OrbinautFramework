/// @function scr_player_flight
function scr_player_flight()
{
	gml_pragma("forceinline");
	
	if action != ACTION_FLIGHT
	{
	    exit;
	}
	
	if flight_timer > 0
	{
	    flight_timer--;
	}

	// Handle ascending
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
	
	// Handle descending
	else
	{
	    if input_press.action_any && flight_timer > 0 && (!is_underwater || carry_target == noone)
	    {
	        ascend_timer = 1;
	    }
		
	    grv = PARAM_GRV_TAILS_DOWN;
	}

	// Play Tails' flight sound
	m_player_play_tails_sound();
	
	// Update animation based on flight timer and environment
	if is_underwater
	{
	    animation = flight_timer > 0 ? ANI_SWIM : ANI_SWIM_TIRED;
	}
	else
	{
	    animation = flight_timer > 0 ? ANI_FLY : ANI_FLY_TIRED;    
	}
}