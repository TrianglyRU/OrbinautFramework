/// @function audio_bgm_is_playing(priority | id)
function audio_bgm_is_playing(check)
{
	// Check if specific track or something on the channel is playing
	switch check
	{
		case PriorityLow:
		{
			var Track = Audio.HighTrack[0];
			if Audio.LowTrack[1] != noone
			{
				return Track;
			}
			else
			{
				return audio_sound_get_track_position(Track) != audio_sound_length(Track);
			}
		}
		break;
		case PriorityHigh:
			return Audio.HighTrack[0];
		break;
		default:
			return audio_is_playing(check);
		break;
	}
}