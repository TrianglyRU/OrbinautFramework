if state = SPECIALSTAGE_STATE_RESULTS
{
    exit;
}

var _c_framework = c_framework;
var _fade = _c_framework.fade;

// Check fade state and initialise the results screen
if _fade.routine == FADEROUTINE.OUT && _fade.state == FADESTATE.PLAINCOLOUR && !audio_is_playing(sfx_warp2)
{
    var _give_emerald = state == SPECIALSTAGE_STATE_EMERALD;
    if _give_emerald && global.emerald_count < 7
    {
        global.emerald_count++;
    }
	
    bg_clear();
    fade_perform_white(FADEROUTINE.IN, 0);
    instance_create(0, 0, obj_gui_results_special, { EmeraldEarned: _give_emerald });
    state = SPECIALSTAGE_STATE_RESULTS;
}

// Check if the game is paused
if _c_framework.state == STATE_PAUSED
{
    exit;
}

// Handle input and state changes
if state != SPECIALSTAGE_STATE_EMERALD
{
    var _input_press = input_get_pressed(0);
    if _input_press.action1
    {
        audio_stop_bgm(0);
        audio_play_sfx(sfx_emerald);
        state = SPECIALSTAGE_STATE_EMERALD;
    }    
    else if _input_press.start
    {
        fade_perform_white(FADEROUTINE.OUT, 3);
        audio_stop_bgm(0.5);
        audio_play_sfx(sfx_warp2);
    }
	
    exit;
}
else if !audio_is_playing(sfx_emerald)
{
    fade_perform_white(FADEROUTINE.OUT, 3);
    audio_play_sfx(sfx_warp2);
}