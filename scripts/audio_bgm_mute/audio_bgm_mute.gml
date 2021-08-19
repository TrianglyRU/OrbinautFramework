/// @function audio_bgm_mute(priority,time)
function audio_bgm_mute(priority, time)
{	
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[2] = EventMute;
			Audio.LowTrack[3] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[2] = EventMute;
			Audio.HighTrack[3] = time;
		}
		break;
	}
}