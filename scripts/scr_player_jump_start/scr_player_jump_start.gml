/// @function scr_player_jump_start
function scr_player_jump_start()
{
	gml_pragma("forceinline");
	
	if forced_roll || action == ACTION_SPINDASH || action == ACTION_DASH
	{
		exit;
	}

	if !input_press.action_any
	{
		exit;
	}

	// Determine ceiling distance based on tile behaviour ("collision mode")
	var MAX_CEILING_DIST = 6;
	
	var _x, _y;
	var _ceil_dist = MAX_CEILING_DIST;

	switch tile_behaviour
	{
		case TILEBEHAVIOUR.DEFAULT:
			_y = y - radius_y;
			_ceil_dist = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];		
		break;

		case TILEBEHAVIOUR.ROTATE_90:
			_x = x - radius_y;
			_ceil_dist = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
		break;

		case TILEBEHAVIOUR.ROTATE_270:
			_x = x + radius_y;
			_ceil_dist = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
		break;
	}

	if _ceil_dist < MAX_CEILING_DIST
	{
		exit;
	}

	// They made four games excluding CD, how did they not fix it :cry:
	if !global.fix_jump_size && global.player_physics != PHYSICS_CD
	{
		radius_x = radius_x_normal;
		radius_y = radius_y_normal;
	}

	if animation != ANI_SPIN
	{	
		y += radius_y - radius_y_spin;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
	}
	else if !global.no_roll_lock && global.player_physics != PHYSICS_CD
	{
		air_lock_flag = true;
	}

	// Apply velocity changes and update state
	vel_x += jump_vel * dsin(angle);
	vel_y += jump_vel * dcos(angle);
	is_jumping = true;
	is_grounded = false;
	on_object = noone;
	set_push_anim_by = noone;
	stick_to_convex = false;
	animation = ANI_SPIN;
	audio_play_sfx(sfx_jump);
	
	// Exit the player control routine
	return true;
}
