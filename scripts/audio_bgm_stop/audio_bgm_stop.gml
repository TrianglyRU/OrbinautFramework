/// @function audio_bgm_stop(audioType,time)
function audio_bgm_stop(audioType,time)
{	
	switch audioType
	{
		case AudioPrimary:
		{
			Audio.PrimaryTrack[0] = EventStop;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case AudioSecondary:
		{
			Audio.SecondaryTrack[0] = EventStop;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}