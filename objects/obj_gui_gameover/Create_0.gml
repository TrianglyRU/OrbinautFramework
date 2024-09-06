#macro GAMEOVER_STATE_SLIDE_IN 0
#macro GAMEOVER_STATE_WAIT 1

// Allow only one instance of this object at a time
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

audio_play_bgm(bgm_gameover);

state = GAMEOVER_STATE_SLIDE_IN;
wait_timer = 720;
frame_number = global.life_count > 0 && c_framework.frame_counter >= 36000;
offset_x = 208;
speed_x = 16;
c_framework.allow_pause = false;