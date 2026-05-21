on_fade_load_menu = function()
{
	room_goto(rm_dev_menu);
}

fade_perform_black(FADE_DIRECTION.IN, 1);
audio_group_load(audiogroup_branding);