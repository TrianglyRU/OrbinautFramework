/// @function audio_bgm_setloop(soundid,looppoint)
function audio_bgm_setloop(soundid, looppoint)
{
	if object_index != Audio
	{
		show_debug_message("WARNING: audio_bgm_setloop function has been called outside of Audio controller! Skipping...");
	}
	else
	{
		TrackLoop[soundid] = looppoint;
	}
}