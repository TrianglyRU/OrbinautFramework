/// @function audio_bgm_is_playing(priority | id)
function audio_bgm_is_playing(check)
{
	switch check
	{
		case PriorityLow:
			return Game.LowTrack[0];
		break;
		case PriorityHigh:
			return Game.HighTrack[0];
		break;
		default:
			return audio_is_playing(check);
		break;
	}
}