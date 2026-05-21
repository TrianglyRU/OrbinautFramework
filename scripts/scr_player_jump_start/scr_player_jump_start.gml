/// @self obj_player
function scr_player_jump_start()
{
	if action == ACTION.SPIN_DASH || action == ACTION.DASH || is_forced_roll
	{
		return false;
	}

	if !input_press_action_any()
	{
		return false;
	}
	
	var _angle_quad = math_get_quadrant(angle);
	var _max_dist = 6;
	var _ceil_dist = _max_dist;
	var _x, _y;
	
	switch _angle_quad
	{
		case QUADRANT.DOWN:	
			_ceil_dist = tile_raycast_2v(x - radius_x, y - radius_y, x + radius_x - 1, y - radius_y, -1, secondary_layer, _angle_quad)[0];	
		break;

		case QUADRANT.RIGHT:
			_ceil_dist = tile_raycast_2h(x - radius_y, y - radius_x, x - radius_y, y + radius_x - 1, -1, secondary_layer, _angle_quad)[0];
		break;

		case QUADRANT.LEFT:
			_ceil_dist = tile_raycast_2h(x + radius_y - 1, y - radius_x, x + radius_y - 1, y + radius_x - 1, 1, secondary_layer, _angle_quad)[0];
		break;
	}

	if _ceil_dist < _max_dist
	{
		return false;
	}
	
	if animation != ANIM.SPIN
	{
		y += radius_y - radius_y_spin;
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
	}
	else if global.roll_lock && global.player_physics != PHYSICS.CD
	{
		air_lock_flag = true;
	}
	
	vel_x += jump_vel * dsin(angle);
	vel_y += jump_vel * dcos(angle);
	
	is_jumping = true;
	is_grounded = false;
	on_object = noone;
	set_push_anim_by = noone;
	stick_to_convex = false;
	animation = ANIM.SPIN;
	
	// Uncomment this to "fix" 1-frame player lag
	// y -= vel_y;
	// scr_player_position();
	
	audio_sfx_play(snd_jump);
	return true;
}
