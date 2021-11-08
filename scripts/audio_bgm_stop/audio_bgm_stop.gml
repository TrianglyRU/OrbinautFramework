/// @function audio_bgm_stop(priority,time)
function audio_bgm_stop(priority,time)
{	
	// Stop track
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[0] = EventStop;
			Audio.LowTrack[2] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[0] = EventStop;
			Audio.HighTrack[2] = time;
		}
		break;
	}
}