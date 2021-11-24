/// @function audio_bgm_mute(channelType,time)
function audio_bgm_mute(channelType,time)
{	
	// Mute track
	switch channelType
	{
		case ChannelPrimary:
		{
			Audio.PrimaryTrack[0] = EventMute;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case ChannelSecondary:
		{
			Audio.SecondaryTrack[0] = EventMute;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}