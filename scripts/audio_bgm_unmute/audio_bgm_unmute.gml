/// @function audio_bgm_unmute(audioType,time)
function audio_bgm_unmute(audioType,time)
{	
	switch audioType
	{
		case AudioPrimary:
		{
			Audio.PrimaryTrack[0] = EventUnmute;
			Audio.PrimaryTrack[2] = time;
		}
		break;
		case AudioSecondary:
		{
			Audio.SecondaryTrack[0] = EventUnmute;
			Audio.SecondaryTrack[2] = time;
		}
		break;
	}
}