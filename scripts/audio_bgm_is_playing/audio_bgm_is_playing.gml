/// @function audio_bgm_is_playing(channelType|soundid)
function audio_bgm_is_playing(check)
{
	// Check if specific track or something on the channel is playing
	switch check
	{
		case ChannelPrimary:
			return Audio.PrimaryTrack[1];
		break;
		case ChannelSecondary:
			return Audio.SecondaryTrack[1];
		break;
		default:
			return audio_is_playing(check);
		break;
	}
}