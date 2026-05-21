/// @self obj_player
function scr_player_roll_start()
{
	if animation == ANIM.SPIN || action == ACTION.SPIN_DASH || action == ACTION.HAMMER_DASH
	{
		return;
	}
	
	if input_down.left || input_down.right || !input_down.down
	{
	    return;
	}
	
	if global.player_physics == PHYSICS.SK
	{
	    if abs(spd) >= 1
	    {
			roll();
	    }
		else
		{
			animation = ANIM.DUCK;
		}
	}
	else if abs(spd) >= 0.5
	{
		roll();
	}
}