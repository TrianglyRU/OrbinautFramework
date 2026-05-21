on_fade_return_to_stage = function()
{
	if !audio_bgm_is_playing()
	{
		room_goto(global.previous_room_id);
		return true;
	}
		
	return false;
}

rings_earned = 0;
continue_earned = false;

audio_bgm_play(snd_bgm_bonus_stage);
bg_convert("Background", 0, 0, 0.25, 0.25, 0);
discord_set_data("BONUS STAGE", "", "room_bonus", undefined);
fade_perform_black(FADE_DIRECTION.IN, 1);