// Inherit the parent event
event_inherited();
event_animator();

on_fade_load_bonus_stage = function()
{
	if !audio_bgm_is_playing()
	{
		room_goto(rm_bonus);
		return true;
	}
		
	return false;
}

depth -= 2;
star_index = 0;
timer = 0;
radius = 0;
transition_flag = false;
animator.start(sprite_index, 0, 0, 2);