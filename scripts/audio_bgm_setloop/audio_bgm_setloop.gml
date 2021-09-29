/// @function audio_bgm_setloop(soundid,loopstart,loopend)
function audio_bgm_setloop(soundid,loopstart,loopend)
{
	if object_index != Audio
	{
		show_debug_message("WARNING: audio_bgm_setloop function has been called outside of Audio controller! Skipping...");
	}
	else
	{
		TrackLoop[soundid][0] = loopstart;
		TrackLoop[soundid][1] = loopend;
	}
}