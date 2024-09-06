/// @function scr_player_slope_repel
function scr_player_slope_repel()
{
	gml_pragma("forceinline");
	
	if stick_to_convex
	{
		exit;
	}

	if ground_lock_timer > 0
	{
		ground_lock_timer--;
		exit;
	}

	if abs(spd_ground) >= 2.5
	{
		exit;
	}
	
	if global.player_physics < PHYSICS_S3
	{
		if math_get_quadrant(angle) != QUADRANT.DOWN
		{	
			spd_ground = 0;	
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
			spd_ground += angle < 180 ? -0.5 : 0.5;
		}
		
		ground_lock_timer = 30;
	}
}