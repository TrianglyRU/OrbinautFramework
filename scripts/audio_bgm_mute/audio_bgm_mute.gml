/// @function audio_bgm_mute(priority,time)
function audio_bgm_mute(priority, time)
{	
	switch priority
	{
		case PriorityLow:
		{
			Game.LowTrack[2] = EventMute;
			Game.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Game.HighTrack[2] = EventMute;
			Game.HighTrack[3] = time;
		}
		break;
	}
}