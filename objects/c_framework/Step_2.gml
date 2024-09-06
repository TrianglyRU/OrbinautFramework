with obj_player
{
    event_perform(ev_other, ev_user1);
}

#region SPRITE ANIMATOR

// Manage sprite animation
var _animator = sprite_animator;
var _enabled_state = state != STATE_PAUSED;

if _animator.module_enabled != _enabled_state
{
    var _asset_array = _animator.asset_array;

    for (var i = array_length(_asset_array) - 2; i >= 0; i -= 2)
    {
        sprite_set_speed(_asset_array[i], _enabled_state ? 1 / _asset_array[i + 1] : 0, spritespeed_framespergameframe);
    }

    _animator.module_enabled = _enabled_state;
}

#endregion

#region BACKGROUND

// Update background layers' parallax scrolling
var _background = background;
var _layer_count = _background.layer_count;

if state != STATE_PAUSED && _layer_count > 0
{
    var _parallax_data = _background.parallax_data;

    // Scroll each background layer based on its velocity
    for (var i = 0; i < _layer_count; i++)
    {
        _parallax_data[i].scroll_x += _parallax_data[i].scroll_vel_x;
        _parallax_data[i].scroll_y += _parallax_data[i].scroll_vel_y;
    }
}

#endregion

#region CAMERA (MOVEMENT)

// Handle camera movement and shake effects
if state != STATE_PAUSED
{
    for (var i = 0; i < CAMERA_COUNT; i++)
    {
        var _camera = camera_get_data(i);

        if _camera == noone || !_camera.allow_movement
        {
            continue;
        }

        var _target = _camera.target;

        if _target != noone && instance_exists(_target)
        {
            var FREESPACE_X = 16;
            var FREESPACE_Y = 32;
            var _width = camera_get_width(i);
            var _height = camera_get_height(i);
			
            var _target_x = _target.x - _camera.pos_x - _width / 2;
            var _target_y = _target.y - _camera.pos_y - _height / 2 + 16;

            // Adjust horizontal velocity based on target position
            if _target_x > 0
            {
                _camera.vel_x = min(_target_x, _camera.vel_x_max);
            }
            else if _target_x < -FREESPACE_X
            {
                _camera.vel_x = max(_target_x + FREESPACE_X, -_camera.vel_x_max);
            }
            else
            {
                _camera.vel_x = 0;
            }

            // Adjust vertical velocity based on target position
            if _target_y > FREESPACE_Y
            {
                _camera.vel_y = min(_target_y - FREESPACE_Y, _camera.vel_y_max);
            }
            else if _target_y < -FREESPACE_Y
            {
                _camera.vel_y = max(_target_y + FREESPACE_Y, -_camera.vel_y_max);
            }
            else
            {
                _camera.vel_y = 0;
            }
        }
        else
        {
            _camera.target = noone;
        }

        // Handle camera shake effect
        if _camera.shake_timer > 0
        {
            if _camera.shake_x == 0
            {
                _camera.shake_x = _camera.shake_timer;
            }
            else if _camera.shake_x < 0
            {
                _camera.shake_x = -1 - _camera.shake_x;
            }
            else
            {
                _camera.shake_x = -_camera.shake_x;
            }

            if _camera.shake_y == 0
            {
                _camera.shake_y = _camera.shake_timer;
            }
            else if _camera.shake_y < 0
            {
                _camera.shake_y = -1 - _camera.shake_y;
            }
            else
            {
                _camera.shake_y = -_camera.shake_y;
            }

            _camera.shake_timer--;
        }
        else
        {
            _camera.shake_x = 0;
            _camera.shake_y = 0;
        }
		
        // Update raw camera position based on velocity and delay
        if _camera.delay_x == 0
        {
            _camera.pos_x_prev = _camera.pos_x;
            _camera.pos_x += _camera.vel_x;
        }
        else if _camera.delay_x > 0
        {
            _camera.delay_x--;
        }

        if _camera.delay_y == 0
        {
            _camera.pos_y_prev = _camera.pos_y;
            _camera.pos_y += _camera.vel_y;
        }
        else if _camera.delay_y > 0
        {
            _camera.delay_y--;
        }
    }
}

#endregion

#region DISTORTION

// Update distortion effects
var _distortion = distortion;

if state != STATE_PAUSED
{
    for (var i = 0; i < 2; i++)
    {
        var _effect = _distortion.effect[i];

        if _effect == -1
        {
            continue;
        }

        var _offset_y = _distortion.offset_y[i];
        var _step = _distortion.offset_step[i];

        _offset_y[0] -= _step;
        _offset_y[1] -= _step;
    }
}

#endregion

#region GAMEPLAY

// Handle gameplay-related updates
if state != STATE_PAUSED
{
    if ring_spill_counter > 0
    {
        ring_spill_counter--;
    }

    var RING_INCREMENT = 100;
    var SCORE_INCREMENT = 50000;
    var _ring_count = global.player_rings;
    var _score_count = global.score_count;

    // Initialise life rewards if not already set
    if array_length(global.life_rewards) == 0
    {
        global.life_rewards = 
        [
            floor(_ring_count / RING_INCREMENT) * RING_INCREMENT + RING_INCREMENT,
            floor(_score_count / SCORE_INCREMENT) * SCORE_INCREMENT + SCORE_INCREMENT,
        ];
    }

    var _rewards = global.life_rewards;

    // Check and award extra life based on ring count
    if _ring_count >= _rewards[0] && _rewards[0] <= 200
    {
        global.life_rewards[0] += RING_INCREMENT;
        global.life_count++;
        audio_play_bgm(bgm_extralife, AUDIO_CHANNEL_JINGLE);
    }

    // Check and award extra life based on score
    if _score_count >= _rewards[1]
    {
        global.life_rewards[1] += SCORE_INCREMENT;
        global.life_count++;
        audio_play_bgm(bgm_extralife, AUDIO_CHANNEL_JINGLE);
    }
}

#endregion

#region CAMERA (RENDER)

// Render camera views to surfaces
for (var i = 0; i < CAMERA_COUNT; i++)
{
    var _camera = camera_get_data(i);

    if _camera == noone 
    {
        continue;
    }
	
    // Create a new surface for the camera view if it does not exist
    if !surface_exists(view_surface_id[i])
    {
		view_surface_id[i] = surface_create(_camera.surface_w, _camera.surface_h);
		
		surface_set_target(view_surface_id[i]);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
    }

    var _x = clamp(floor(_camera.pos_x + _camera.offset_x), _camera.min_x, _camera.max_x - camera_get_width(i)) + _camera.shake_x;
    var _y = clamp(floor(_camera.pos_y + _camera.offset_y), _camera.min_y, _camera.max_y - camera_get_height(i)) + _camera.shake_y;

    // Set the view position for the camera
    camera_set_view_pos(view_camera[i], _x - ENGINE_RENDERER_HORIZONTAL_BUFFER, _y);
}

#endregion

#region AUDIO

// Manage audio playback
var _audio = audio;

// Set SFX emitter gain
audio_emitter_gain(_audio.emitter_sfx, global.sound_volume);

for (var i = 0; i < ENGINE_AUDIO_BGM_CHANNELS; i++)
{
    var _channel_bgm = _audio.current_bgm[i];

    if _channel_bgm == -1
    {
        continue;
    }

    // Set BGM emitter gain
    audio_emitter_gain(_audio.emitter_bgm[i], global.music_volume);
	
	var _channel_state = _audio.channel_state[i];
	
	// audio_sound_length() == -1 checks if the sound is no longer playing
    if audio_sound_length(_channel_bgm) == -1 || _channel_state == ENGINE_AUDIO_STATE_STOP && audio_sound_get_gain(_channel_bgm) == 0
    {
		 audio_stop_sound(_channel_bgm);
        _audio.current_bgm[i] = -1;
        _audio.channel_state[i] = ENGINE_AUDIO_STATE_DEFAULT;
		
        continue;
    }
	
    if i == AUDIO_CHANNEL_JINGLE
    {
        continue;
    }

    var _last_channel_bgm = _audio.current_bgm[AUDIO_CHANNEL_JINGLE];

    if _last_channel_bgm != -1
    {
        if _channel_state != ENGINE_AUDIO_STATE_MUTE
        {
            _audio.channel_state[i] = ENGINE_AUDIO_STATE_MUTE_BY_JINGLE;
        }
        audio_mute_bgm(0, i);
    }
    else if _channel_state == ENGINE_AUDIO_STATE_MUTE_BY_JINGLE
    {
        audio_unmute_bgm(1, i);
    }
}

#endregion

// Reactivate objects that were stopped during the inactive framework 
// state to let the engine draw them
m_framework_activate_stopped_objects();