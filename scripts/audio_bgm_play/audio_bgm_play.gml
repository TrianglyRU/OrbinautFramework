/// @function audio_bgm_play(priority,soundid,looppoint)
function audio_bgm_play(priority, soundid, looppoint)
{	
	// Exit if empty audio set
	if !soundid
	{
		exit;
	}
	
	// Play new track
	switch priority
	{
		case PriorityLow:
		{
			audio_stop_sound(Game.LowTrack[0]);
			
			Game.LowTrack[0] = audio_play_sound(soundid, 0, false);
			Game.LowTrack[1] = looppoint == other ? Game.TrackLoop[soundid] : looppoint;
			Game.LowTrack[2] = EventIdle;
		}
		break;
		case PriorityHigh:
		{
			audio_stop_sound(Game.HighTrack[0]);

			Game.HighTrack[0] = audio_play_sound(soundid, 0, false);
			Game.HighTrack[1] = looppoint == other ? Game.TrackLoop[soundid] : looppoint;
			Game.HighTrack[2] = EventIdle;
		}
		break;
	}
	audio_sound_gain(soundid, Game.MusicVolume, 0);
}