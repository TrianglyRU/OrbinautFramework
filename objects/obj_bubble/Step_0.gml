if sprite_index == spr_bubble_burst
{
	if animator.timer < 0
	{
		instance_destroy();
	}
	
	return;
}

if bubble_type != BUBBLE.COUNTDOWN && floor(y) < obj_water.y
{
    if image_index == 5
    {
        burst();
    }
    else
    {
        instance_destroy();
    }
	
    return;
}

wobble_offset++;
wobble_offset %= (array_length(wobble_data) - 1);

x = xstart + wobble_data[wobble_offset] * wobble_direction;
y += vel_y;

if bubble_type != BUBBLE.COUNTDOWN
{
    if animator.timer > 0 && image_index == 1 + bubble_type * 2
    {
		animator.clear(image_index);
    }
}
else if animator.timer < 0
{
	instance_destroy();
	
    with instance_create(x, y, obj_countdown)
	{
		image_index = other.countdown_frame;
	}
	
    return;
}

if bubble_type != BUBBLE.LARGE || animator.timer != 0
{
    return;
}

FOR_EACH_PLAYER
{
    var _player = player_get(_p);
	
    if _player.state >= PLAYER_STATE.NO_INTERACT || global.player_shields[_p] == SHIELD.BUBBLE
    {
        continue;
    }

	if point_in_rectangle(floor(_player.x), floor(_player.y), floor(bbox_left), floor(bbox_top), floor(bbox_right) - 1, floor(bbox_bottom) - 1)
	{
		burst();
		
	    if _player.player_index == 0 && audio_is_playing(snd_bgm_drowning)
	    {
	        _player.restart_bgm(obj_rm_stage.bgm_track);
	    }
		
		if _player.action != ACTION.FLIGHT && !_player.is_true_glide()
		{
			_player.animation = ANIM.BREATHE;
			_player.reset_substate();
		}
		
		_player.air_timer = AIR_TIMER_DEFAULT;
		_player.ground_lock_timer = 35;
		_player.vel_x = 0;
		_player.vel_y = 0;
		_player.spd = 0;
		
	    audio_sfx_play(snd_breathe);
		
		break;
	}
}