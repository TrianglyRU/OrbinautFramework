/// @function audio_sfx_play(soundid,loops)
function audio_sfx_play(soundid, loops)
{	
	if !loops
	{
		if audio_is_playing(soundid)
		{
			audio_stop_sound(soundid);
		}
		audio_play_sound(soundid, 0, loops);
		
	}
	else
	{
		if !audio_is_playing(soundid)
		{
			audio_play_sound(soundid, 0, loops);
		}
	}
	audio_sound_gain(soundid, Game.SoundVolume, 0);
}