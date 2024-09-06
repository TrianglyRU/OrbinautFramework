/// @function scr_player_slope_resist
function scr_player_slope_resist()
{
	gml_pragma("forceinline");
	
	if action == ACTION_HAMMERDASH || action == ACTION_DASH
	{
		exit;
	}
	
	if angle >= 135 && angle < 225	// is (angle + 135) % 360 >= 270
	{
		exit;
	}
	
	var _slope_grv = 0.125 * dsin(angle);
	
	if spd_ground != 0 || global.player_physics >= PHYSICS_S3 && abs(_slope_grv) > 0.05078125
	{
		spd_ground -= _slope_grv;
	}
}