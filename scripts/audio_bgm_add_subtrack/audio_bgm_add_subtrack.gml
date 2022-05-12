/// @function audio_bgm_add_subtrack(soundid,soundid2)
function audio_bgm_add_subtrack(soundid,soundid2)
{
	if object_index != Audio
    {
        show_debug_message("WARNING: audio_bgm_add_subtrack function has been called outside of Audio controller! Skipping...");
    }
	else
	{
		ds_map_add(SubTrackData, soundid, soundid2);
	}
}