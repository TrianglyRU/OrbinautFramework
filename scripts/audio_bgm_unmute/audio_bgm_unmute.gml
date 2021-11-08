/// @function audio_bgm_unmute(priority,time)
function audio_bgm_unmute(priority,time)
{	
	// Unmute track
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[0] = EventUnmute;
			Audio.LowTrack[2] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[0] = EventUnmute;
			Audio.HighTrack[2] = time;
		}
		break;
	}
}