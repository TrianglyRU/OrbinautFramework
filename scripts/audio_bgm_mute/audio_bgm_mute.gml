/// @function audio_bgm_mute(priority,time)
function audio_bgm_mute(priority,time)
{	
	// Mute track
	switch priority
	{
		case PriorityLow:
		{
			Audio.LowTrack[0] = EventMute;
			Audio.LowTrack[2] = time;
		}
		break;
		case PriorityHigh:
		{
			Audio.HighTrack[0] = EventMute;
			Audio.HighTrack[2] = time;
		}
		break;
	}
}