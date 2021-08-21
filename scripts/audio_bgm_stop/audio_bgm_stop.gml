/// @function audio_bgm_stop(priority,time)
function audio_bgm_stop(priority,time)
{	
	// Stop track
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[2] = EventStop;
			Audio.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[2] = EventStop;
			Audio.HighTrack[3] = time;
		}
		break;
	}
}