#macro PAUSE_STATE_NAVIGATION 0
#macro PAUSE_STATE_RESTART 1
#macro PAUSE_STATE_EXIT 2
	
state = PAUSE_STATE_NAVIGATION;
highlight_timer = 0;
option_id = 0;
c_framework.state = STATE_PAUSED;
	
audio_pause_all();
audio_play_sfx(sfx_bumper);