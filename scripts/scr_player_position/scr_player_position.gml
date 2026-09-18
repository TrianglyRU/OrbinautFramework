/// @self obj_player
function scr_player_position(_substeps = 1)
{
	if stick_to_convex
	{
		vel_x = clamp(vel_x, -16, 16);
		vel_y = clamp(vel_y, -16, 16);
	}
	
	x += vel_x / _substeps;
	y += vel_y / _substeps;
	
	if !is_grounded
	{
		vel_y += grv / _substeps;
	}
}