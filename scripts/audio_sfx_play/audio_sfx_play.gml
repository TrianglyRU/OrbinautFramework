/// @function audio_sfx_play(soundid,doloop)
function audio_sfx_play(soundid, doloop)
{	
	if !doloop
	{
		if audio_is_playing(soundid)
		{
			audio_stop_sound(soundid);
		}
		audio_play_sound(soundid, 0, doloop);
	}
	else
	{
		if !audio_is_playing(soundid)
		{
			audio_play_sound(soundid, 0, doloop);
		}
	}
}