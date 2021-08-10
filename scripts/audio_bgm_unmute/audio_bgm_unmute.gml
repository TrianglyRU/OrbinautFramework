/// @function audio_bgm_unmute(priority,time)
function audio_bgm_unmute(priority, time)
{	
	switch priority
	{
		case PriorityLow:
		{
			Game.LowTrack[2]  = EventUnmute;
			Game.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Game.HighTrack[2] = EventUnmute;
			Game.HighTrack[3] = time;
		}
		break;
	}
}