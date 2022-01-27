/// @function audio_bgm_stop(channelType,time)
function audio_bgm_stop(channelType,time)
{	
	switch channelType
	{
		case TypePrimary:
		{
			Audio.PrimaryTrack[0] = EventStop;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case TypeSecondary:
		{
			Audio.SecondaryTrack[0] = EventStop;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}