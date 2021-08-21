/// @function audio_bgm_unmute(priority,time)
function audio_bgm_unmute(priority,time)
{	
	// Unmute track
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[2]  = EventUnmute;
			Audio.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[2] = EventUnmute;
			Audio.HighTrack[3] = time;
		}
		break;
	}
}