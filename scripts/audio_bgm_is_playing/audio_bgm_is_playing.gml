/// @function audio_bgm_is_playing(channelType|soundid)
function audio_bgm_is_playing(check)
{
	switch check
	{
		case TypePrimary:
			return Audio.PrimaryTrack[1];
		break;
		case TypeSecondary:
			return Audio.SecondaryTrack[1];
		break;
		default:
			return audio_is_playing(check);
		break;
	}
}