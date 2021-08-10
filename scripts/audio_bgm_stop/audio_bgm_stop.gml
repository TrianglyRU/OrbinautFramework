/// @function audio_bgm_stop(priority,time)
function audio_bgm_stop(priority, time)
{	
	switch priority
	{
		case PriorityLow:
		{
			Game.LowTrack[2] = EventStop;
			Game.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Game.HighTrack[2] = EventStop;
			Game.HighTrack[3] = time;
		}
		break;
	}
}