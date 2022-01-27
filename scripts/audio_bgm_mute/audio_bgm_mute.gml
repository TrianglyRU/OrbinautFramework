/// @function audio_bgm_mute(channelType,time)
function audio_bgm_mute(channelType,time)
{	
	switch channelType
	{
		case TypePrimary:
		{
			Audio.PrimaryTrack[0] = EventMute;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case TypeSecondary:
		{
			Audio.SecondaryTrack[0] = EventMute;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}