/// @self obj_player
function scr_player_slope_resist()
{
	if action == ACTION.HAMMER_DASH || action == ACTION.DASH
	{
		return;
	}
	
	if angle >= 135 && angle < 225
	{
		return;
	}
	
	var _slope_grv = 0.125 * dsin(angle);
	
	if spd != 0 || global.player_physics >= PHYSICS.S3 && abs(_slope_grv) > 0.05078125
	{
		spd -= _slope_grv;
	}
}