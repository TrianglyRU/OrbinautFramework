// Stop animation if the first frame is reached
if ani_get_frame() == 0
{
    ani_stop();
}

for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
	
    obj_act_solid(_player, SOLIDOBJECT.FULL, SOLIDATTACH.RESET_PLAYER);

    // Skip if the current animation frame is not the first
    if ani_get_frame() != 0
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
        _player.animation = FlipPlayer ? ANI_FLIP : ANI_BOUNCE;
    }
    else
    {
        _player.vel_x = 0;
    }

    
    _player.y += image_yscale * 8;
    _player.vel_y = image_yscale * -launch_force;

    _player.m_player_reset();
    ani_update_frame(1);
    ani_resume();
    audio_play_sfx(sfx_spring);
}