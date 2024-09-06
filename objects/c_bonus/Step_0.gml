var _framework = c_framework;
var _fade = _framework.fade;

// Check fade state and handle room transition
if _fade.routine == FADEROUTINE.OUT && _fade.state == FADESTATE.PLAINCOLOUR
{
    room_goto(global.previous_room_id);
}

// Check if the game is paused
if _framework.state == STATE_PAUSED
{
    exit;
}

var _input_press = input_get_pressed(0);

// Handle action1 input (give 10 rings)
if _input_press.action1 
{
    audio_play_sfx(sfx_ring_left);
    audio_play_sfx(sfx_ring_right);
	
    global.player_rings = min(global.player_rings + 10, 999);
	
    if !continue_earned && global.player_rings - rings_saved >= 50 
    {
        continue_earned = true;
        global.continue_count++;
        audio_play_sfx(sfx_continue);
    }
}

// Handle action2 input (give all players a random shield)
else if _input_press.action2 
{
    var _shield = choose(SHIELD_NORMAL, SHIELD_FIRE, SHIELD_BUBBLE, SHIELD_LIGHTNING);
	
    for (var i = 0; i < ENGINE_PLAYER_MAX_COUNT; i++)
    {
        global.player_shield[i] = _shield;
    }
	
    switch _shield
    {
        case SHIELD_NORMAL:
            audio_play_sfx(sfx_shield);
        break;
        case SHIELD_FIRE:
            audio_play_sfx(sfx_shield_fire);
        break;
        case SHIELD_BUBBLE:
            audio_play_sfx(sfx_shield_bubble);
        break;
        case SHIELD_LIGHTNING:
            audio_play_sfx(sfx_shield_lightning);
        break;
    }
}

// Handle start button input (initalise room transition)
else if _input_press.start 
{
    fade_perform_black(FADEROUTINE.OUT, 1);
    audio_stop_bgm(0.5);
}