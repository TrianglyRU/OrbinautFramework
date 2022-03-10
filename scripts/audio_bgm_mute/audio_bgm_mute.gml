/// @function audio_bgm_mute(audioType,time)
function audio_bgm_mute(audioType,time)
{	
	switch audioType
	{
		case AudioPrimary:
		{
			Audio.PrimaryTrack[0] = EventMute;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case AudioSecondary:
		{
			Audio.SecondaryTrack[0] = EventMute;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}