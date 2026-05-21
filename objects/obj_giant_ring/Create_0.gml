if ds_list_find_index(global.giant_rings, id) != -1
{
	instance_destroy();
	return;
}

// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.PAUSE);

enum GIANT_RING_STATE
{
	IDLE,
	ENTRY
}

on_fade_load_special_stage = function()
{
	if !audio_is_playing(snd_warp_enter)
	{
		room_goto(rm_special);
		return true;
	}
				
	return false;
}

depth = draw_depth(30);
state = GIANT_RING_STATE.IDLE;
wait_timer = 32;