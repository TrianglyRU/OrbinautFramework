/// @function audio_bgm_stop(channelType,time)
function audio_bgm_stop(channelType,time)
{	
	// Stop track
	switch channelType
	{
		case ChannelPrimary:
		{
			Audio.PrimaryTrack[0] = EventStop;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case ChannelSecondary:
		{
			Audio.SecondaryTrack[0] = EventStop;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}