// Handle large burst bubble animation ending
if BubbleType == BUBBLE_TYPE_LARGE_BURST
{
    if ani_get_ended()
    {
        instance_destroy();
    }
	
    exit;
}

var _ani_frame = ani_get_frame();

// Handle bubble behavior when it's above water level
if BubbleType != BUBBLE_TYPE_COUNTDOWN && floor(y) < c_stage.water_level
{
    if _ani_frame == BUBBLE_FINAL_FRAME
    {
        m_bubble_burst();
    }
    else
    {
        instance_destroy();
    }
	
    exit;
}

// Apply wobble effect and update position
wobble_offset = (++wobble_offset) % wobble_offset_max;
x = xstart + wobble_data[wobble_offset] * WobbleDirection;
y += vel_y;

if BubbleType != BUBBLE_TYPE_COUNTDOWN
{
    if _ani_frame == 1 + BubbleType * 2
    {
        ani_stop();
    }
}

// Replace the bubble with a countdown number object
else if _ani_frame == 4
{
    instance_destroy();
    instance_create(x, y, obj_countdown, { CountdownFrame: CountdownFrame });
    exit;
}

// Handle large bubble collection by a player
if BubbleType != BUBBLE_TYPE_LARGE || _ani_frame != BUBBLE_FINAL_FRAME
{
    exit;
}

for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
	
    if _player.state >= PLAYER_STATE_NO_CONTROL || _player.shield == SHIELD_BUBBLE
    {
        continue;
    }

    var _dist_x = floor(_player.x) - floor(x);
    var _dist_y = floor(_player.y) - floor(y);
    
    if _dist_x < -16 || _dist_x >= 16 || _dist_y < 0 || _dist_y >= 16
    {
        continue;
    }

    m_bubble_burst();
	
    // Reset music if the lead player collects the bubble
    if _player.player_index == 0 && audio_is_playing(bgm_drowning)
    {
        audio_reset_bgm(c_stage.bgm_track, _player);
    }

    // Reset the player
    if _player.action != ACTION_FLIGHT && (_player.action != ACTION_GLIDE || _player.action_state == GLIDE_STATE_FALL)
    {
		_player.animation = ANI_BREATHE;
		_player.m_player_reset();
    }
	
    _player.air_timer = AIR_TIMER_DEFAULT;
    _player.ground_lock_timer = 35;
    _player.vel_x = 0;
    _player.vel_y = 0;
    _player.spd_ground = 0;

    audio_play_sfx(sfx_breathe);
}