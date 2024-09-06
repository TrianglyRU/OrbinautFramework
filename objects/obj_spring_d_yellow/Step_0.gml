// Stop animation if the first frame is reached
if ani_get_frame() == 0
{
	ani_stop();
}

for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
		
	obj_act_solid(_player, SOLIDOBJECT.FULL, SOLIDATTACH.RESET_PLAYER);
		
	// Skip if the current animation frame is not the first or if the player is not aligned horizontally
	if ani_get_frame() != 0 || (_player.x - x + 4 * image_xscale) * image_xscale < 0
	{
		continue;
	}
		
	var _collision_side = image_yscale > 0 ? SOLIDCOLLISION.TOP : SOLIDCOLLISION.BOTTOM;
		
	if !obj_check_solid(_player, _collision_side)
	{
		continue;
	}
		
	// Update the player
	if image_yscale >= 0
	{
	    _player.animation = ANI_BOUNCE;
	}
			
	_player.y +=  image_yscale * 8;
	_player.facing = image_xscale;
	_player.vel_x = launch_force * image_xscale;
	_player.vel_y = -launch_force * image_yscale;		
		
	_player.m_player_reset();
	ani_update_frame(1);
	ani_resume();
	audio_play_sfx(sfx_spring);
}