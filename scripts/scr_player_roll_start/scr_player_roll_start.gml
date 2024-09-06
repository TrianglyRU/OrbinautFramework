/// @function scr_player_roll_start
function scr_player_roll_start()
{
	gml_pragma("forceinline");
	
	if action == ACTION_SPINDASH || action == ACTION_HAMMERDASH
	{
	    exit;
	}
	
	// Exit if forced roll is not active and either left or right input is pressed
	if !forced_roll && (input_down.left || input_down.right)
	{
	    exit;
	}

	var _allowed_to_roll = false;

	// Determine if the player is allowed to roll
	if input_down.down
	{
	    if global.player_physics == PHYSICS_SK
	    {
	        if abs(spd_ground) >= 1
	        {
	            _allowed_to_roll = true;
	        }
	        else
	        {
	            animation = ANI_DUCK;
	        }
	    }
	    else if abs(spd_ground) >= 0.5
	    {
	        _allowed_to_roll = true;
	    }
	}
	
	if !_allowed_to_roll && !forced_roll
	{
	    exit;
	}

	// Update player’s radius and animation
	y += radius_y - radius_y_spin;
	radius_x = radius_x_spin;
	radius_y = radius_y_spin;
	animation = ANI_SPIN;
	audio_play_sfx(sfx_roll);
}
