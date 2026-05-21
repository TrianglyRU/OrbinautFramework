/// @self obj_player
function scr_player_slope_repel()
{
	if stick_to_convex
	{
		return;
	}

	if ground_lock_timer > 0
	{
		ground_lock_timer--;
		return;
	}

	if abs(spd) >= 2.5
	{
		return;
	}
	
	if global.player_physics < PHYSICS.S3
	{
		if math_get_quadrant(angle) != QUADRANT.DOWN
		{	
			spd = 0;	
			ground_lock_timer = 30;
			is_grounded = false;
		} 
	}
	else if angle > 33.75 && angle <= 326.25
	{
		if angle > 67.5 && angle <= 292.5
		{
			is_grounded = false;
		}
		else
		{
			spd += angle < 180 ? -0.5 : 0.5;
		}
		
		ground_lock_timer = 30;
	}
}