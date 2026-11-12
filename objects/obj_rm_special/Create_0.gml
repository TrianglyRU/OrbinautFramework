enum SPECIAL_STAGE_STATE
{
	IDLE,
	RESULTS,
	EMERALD,
	ALL_EMERALDS
}

start_results = function()
{
	if !audio_is_playing(snd_warp_exit)
	{
		var _previous_state = state;
	
		if state == SPECIAL_STAGE_STATE.EMERALD
		{
			global.emerald_count = min(global.emerald_count + 1, 7);
		}
		else if state == SPECIAL_STAGE_STATE.ALL_EMERALDS
		{
			global.emerald_count = 7;
		}
		
		state = SPECIAL_STAGE_STATE.RESULTS;
		
		layer_destroy("Reflection");
		layer_destroy("Close_Clouds");
		layer_destroy("Far_Clouds");
		
		bg_clear_data();
		deform_clear_all();
		fade_perform_white(FADE_DIRECTION.IN, 0);
	
		with instance_create(0, 0, obj_gui_results_special)
		{
			message_emerald = _previous_state >= SPECIAL_STAGE_STATE.EMERALD;
		};
	
		return true;
	}
	
	return false;
}

state = SPECIAL_STAGE_STATE.IDLE;

bg_parallax("Far_Clouds", 0, 0, 0, 0, 0);
bg_parallax("Close_Clouds", 0, 0, -0.05, 0, 0);
bg_parallax("Reflection", 0, 0, -0.05, 0, 0);

deform_layers(["Reflection"], 1, 0.25, DEFORM_DATA.LBZ_1, undefined);

discord_set_data("SPECIAL STAGE", "", "room_special", undefined);
audio_bgm_play(snd_bgm_special_stage);
fade_perform_white(FADE_DIRECTION.IN, 1);