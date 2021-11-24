/// @function audio_bgm_unmute(channelType,time)
function audio_bgm_unmute(channelType,time)
{	
	// Unmute track
	switch channelType
	{
		case ChannelPrimary:
		{
			Audio.PrimaryTrack[0] = EventUnmute;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case ChannelSecondary:
		{
			Audio.SecondaryTrack[0] = EventUnmute;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}