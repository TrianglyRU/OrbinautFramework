if obj_game.fade_state != FADE_STATE.NONE || state = SPECIAL_STAGE_STATE.RESULTS
{
	return;
}

if state == SPECIAL_STAGE_STATE.IDLE
{
    var _input_press = input_check_pressed(0);
    var _input_held = input_check(0);
	
    if _input_press.action1
    { 
		state = _input_held.action2 ? SPECIAL_STAGE_STATE.ALL_EMERALDS : SPECIAL_STAGE_STATE.EMERALD;		
		audio_bgm_play(snd_bgm_emerald);
    }
    else if _input_press.start
    {
		audio_bgm_stop(1);
        audio_sfx_play(snd_warp_exit);
        fade_perform_white(FADE_DIRECTION.OUT, 3, start_results);  
    }
}
else if !audio_is_playing(snd_bgm_emerald)
{
	audio_sfx_play(snd_warp_exit);
    fade_perform_white(FADE_DIRECTION.OUT, 3, start_results);
}