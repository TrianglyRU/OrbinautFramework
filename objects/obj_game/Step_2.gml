/// @description Late Update
if room == rm_startup
{
	return;
}

with obj_gameobject
{
	event_user(12);
}

var _sfx_volume = global.sound_volume;
var _bgm_volume = global.music_volume;

audio_emitter_gain(audio_emitter_sfx, _sfx_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_gain(audio_emitter_bgm[_i], _bgm_volume);
	
	var _state = audio_channel_states[_i];
    var _bgm = audio_channel_bgms[_i];
	
    if _bgm == undefined
    {
        continue;
    }
	
    if !audio_is_playing(_bgm) || _state == CHANNEL_STATE.STOP && audio_sound_get_gain(_bgm) == 0
    {
		audio_channel_states[_i] = CHANNEL_STATE.DEFAULT;
		audio_channel_bgms[_i] = undefined;
		audio_stop_sound(_bgm);
		
        continue;
    }
	
    if _i == AUDIO_CHANNEL_JINGLE
    {
        continue;
    }
	
	var _jingle_bgm = audio_channel_bgms[AUDIO_CHANNEL_JINGLE];
	
    if _jingle_bgm != undefined
    {
        if _state != CHANNEL_STATE.MUTE
        {
            audio_channel_states[_i] = CHANNEL_STATE.TEMP_MUTE;
        }
		
        audio_bgm_mute(0, _i);
    }
    else if _state == CHANNEL_STATE.TEMP_MUTE
    {
        audio_bgm_unmute(1, _i);
    }
}

FOR_EACH_CAMERA
{
    var _camera_data = view_data[_c];
	
    if _camera_data == undefined
    {
        continue;
    }
	
	// Create a surface for the camera if it doesn't exist. Doing so in Draw event results in a blank frame
	if !surface_exists(view_surface_id[_c])
	{
		view_surface_id[_c] = surface_create(_camera_data.surface_w, _camera_data.surface_h);
	}
	
	if state != GAME_STATE.STOP_ALL && _camera_data.allow_updates
	{
		var _target = _camera_data.target;
		
	    if _target != noone
	    {
			instance_activate_object(_target);
			
			// Track an object if set to do so; obj_player does it on its own in the scr_player_camera() script
			if instance_exists(_target)
			{
				var _w = camera_get_width(_c);
				var _h = camera_get_height(_c);
	
		        var _target_x = _target.x - _camera_data.raw_x - _w * 0.5;
		        var _target_y = _target.y - _camera_data.raw_y - _h * 0.5 + 16;
				var _max_vel_x = _camera_data.max_vel_x;
				var _max_vel_y = _camera_data.max_vel_y;
				
		        if _target_x > 0
		        {
		            _camera_data.vel_x = min(_target_x, _max_vel_x);
		        }
		        else if _target_x < -CAMERA_FREESPACE_X
		        {
		            _camera_data.vel_x = max(_target_x + CAMERA_FREESPACE_X, -_max_vel_x);
		        }
		        else
		        {
		            _camera_data.vel_x = 0;
		        }
				
		        if _target_y > CAMERA_FREESPACE_Y
		        {
		            _camera_data.vel_y = min(_target_y - CAMERA_FREESPACE_Y, _max_vel_y);
		        }
		        else if _target_y < -CAMERA_FREESPACE_Y
		        {
		            _camera_data.vel_y = max(_target_y + CAMERA_FREESPACE_Y, -_max_vel_y);
		        }
		        else
		        {
		            _camera_data.vel_y = 0;
		        }
		    }
		    else
		    {
		        _camera_data.target = noone;
		    }
		}
		
		if _camera_data.max_vel_x < CAMERA_MAX_VEL_X
		{
			_camera_data.max_vel_x += 0.25;
		}
		
		if _camera_data.max_vel_y < CAMERA_MAX_VEL_Y
		{
			_camera_data.max_vel_y += 0.25;
		}
		
	    if _camera_data.shake_timer > 0
	    {
	        if _camera_data.shake_offset == 0
	        {
	            _camera_data.shake_offset = _camera_data.shake_timer;
	        }
	        else if _camera_data.shake_offset < 0
	        {
	            _camera_data.shake_offset = -1 - _camera_data.shake_offset;
	        }
	        else
	        {
	            _camera_data.shake_offset = -_camera_data.shake_offset;
	        }

	        _camera_data.shake_timer--;
	    }
	    else
	    {
	        _camera_data.shake_offset = 0;
	    }
		
	    if _camera_data.delay_x == 0
	    {
	        _camera_data.pos_x_prev = _camera_data.raw_x;
	        _camera_data.raw_x += _camera_data.vel_x;
	    }
	    else if _camera_data.delay_x > 0
	    {
	        _camera_data.delay_x--;
	    }
		
	    if _camera_data.delay_y == 0
	    {
	        _camera_data.pos_y_prev = _camera_data.raw_y;
	        _camera_data.raw_y += _camera_data.vel_y;
	    }
	    else if _camera_data.delay_y > 0
	    {
	        _camera_data.delay_y--;
	    }
	}
	
	var _raw_pos_x = floor(_camera_data.raw_x + _camera_data.offset_x);
	var _raw_pos_y = floor(_camera_data.raw_y + _camera_data.offset_y);
	
	var _x = clamp(_raw_pos_x, _camera_data.left_bound, _camera_data.right_bound - camera_get_width(_c)) + _camera_data.shake_offset;
    var _y = clamp(_raw_pos_y, _camera_data.top_bound, _camera_data.bottom_bound - camera_get_height(_c)) + _camera_data.shake_offset;
	
    camera_set_view_pos(view_camera[_c], _x - CAMERA_HORIZONTAL_BUFFER, _y);
}

if state != GAME_STATE.STOP_ALL
{
	if global.ring_spill_counter > 0
    {
        global.ring_spill_counter--;
    }
	
	var _life_count_prev = global.life_count;
	
    if global.player_rings >= global.life_rewards[0] && global.life_rewards[0] <= 200
    {
        global.life_rewards[0] += RINGS_THRESHOLD;
		global.life_count++;
    }
	
    if global.score_count >= global.life_rewards[1]
    {
        global.life_rewards[1] += SCORE_THRESHOLD;
		global.life_count++;
    }
	
	if _life_count_prev != global.life_count
	{
		audio_bgm_play(snd_bgm_extra_life, AUDIO_CHANNEL_JINGLE);
	}
	
	bg_scroll_x++;
	bg_scroll_y++;
	deformation_timer++;
	
	for (var _i = ds_list_size(deformations_data) - 1; _i >= 0; _i--)
	{
		var _data = deformations_data[| _i];
		
		if _data != undefined
		{
			_data.offset = deformation_timer * -_data.spd;
		}
	}
	
	if !sprite_update_enabled
	{
	    for (var _i = array_length(sprite_array) - 2; _i >= 0; _i -= 2)
	    {
	        sprite_set_speed(sprite_array[_i], 1 / sprite_array[_i + 1], spritespeed_framespergameframe);
	    }
	
	    sprite_update_enabled = true;
	}
}
else if sprite_update_enabled
{
	for (var _i = array_length(sprite_array) - 2; _i >= 0; _i -= 2)
	{
	    sprite_set_speed(sprite_array[_i], 0, spritespeed_framespergameframe);
	}
	
	sprite_update_enabled = false;
}

// Activate stopped objects to let the engine draw them
if state != GAME_STATE.NORMAL
{
	restore_stopped_objects();
}

with obj_gameobject
{
	event_user(13);
}