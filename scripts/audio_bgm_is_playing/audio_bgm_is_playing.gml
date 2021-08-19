/// @function audio_bgm_is_playing(priority | id)
function audio_bgm_is_playing(check)
{
	switch check
	{
		case PriorityLow:
			return Audio.LowTrack[0];
		break;
		case PriorityHigh:
			return Audio.HighTrack[0];
		break;
		default:
			return audio_is_playing(check);
		break;
	}
}