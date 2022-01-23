/// @function audio_bgm_add_channel(soundid,soundid2)
function audio_bgm_add_channel(soundid,soundid2)
{
	if object_index != Audio
    {
        show_debug_message("WARNING: audio_bgm_add_channel function has been called outside of Audio controller! Skipping...");
    }
	else
	{
		ds_map_add(SecondChannel, soundid, soundid2);
	}
}