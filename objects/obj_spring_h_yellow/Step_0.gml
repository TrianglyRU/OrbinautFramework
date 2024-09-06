// Stop animation if the first frame is reached
if ani_get_frame() == 0
{
	ani_stop();
}
	
for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
		
	obj_act_solid(_player, SOLIDOBJECT.FULL);
	
	// Skip if the current animation frame is not the first or the player is airborne
	if ani_get_frame() != 0 || !_player.is_grounded
	{
		continue;
	}
		
	var _collision_side = image_xscale > 0 ? SOLIDCOLLISION.RIGHT : SOLIDCOLLISION.LEFT;
		
	if !obj_check_solid(_player, _collision_side)
	{
		// Skip if the player is moving in the opposite direction of the object's scale
		if sign(_player.vel_x) != sign(image_xscale) && _player.vel_x != 0
		{
			continue;
		}
		
		// Check vertical alignment with the collision area
		var _y = floor(_player.y);
		if _y < y - 24 || _y >= y + 24
		{
			continue;
		}
		
		var _l_bound = 0; 
		var _r_bound = 0;
				
		if image_xscale >= 0
		{
			_l_bound = x;
			_r_bound = x + 40;
		}
		else
		{
			_l_bound = x - 40;
			_r_bound = x;
		}
		
		// Check horizontal alignment with the collision area
		var _x = floor(_player.x);
		if _x < _l_bound || _x >= _r_bound
		{
			continue;
		}
	}
	
	// Update the player
	_player.x -= image_xscale * 8;
	_player.facing = image_xscale;
	_player.vel_x = image_xscale * launch_force;
	_player.spd_ground = _player.vel_x;
	_player.action = ACTION_NONE;
	_player.ground_lock_timer = 16;
		
	ani_update_frame(1);
	ani_resume();
	audio_play_sfx(sfx_spring);
}