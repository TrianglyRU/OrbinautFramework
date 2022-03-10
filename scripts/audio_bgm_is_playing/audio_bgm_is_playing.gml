/// @function audio_bgm_is_playing(audioType|soundid)
function audio_bgm_is_playing(check)
{
	switch check
	{
		case AudioPrimary:
			return Audio.PrimaryTrack[1];
		break;
		case AudioSecondary:
			return Audio.SecondaryTrack[1];
		break;
	}
	return audio_is_playing(check);
}