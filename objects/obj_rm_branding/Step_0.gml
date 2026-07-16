if obj_game.fade_state == FADE_STATE.NONE
{
	if FRAME_COUNTER  == 96 || input_check(0).start 
	{
	    fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_load_menu);
	}
}