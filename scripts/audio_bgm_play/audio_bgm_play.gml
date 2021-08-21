/// @function audio_bgm_play(priority,soundid,looppoint)
function audio_bgm_play(priority,soundid,looppoint)
{	
	// Exit if no audio set
	if !soundid
	{
		exit;
	}
	
	// Play new track
	switch priority
	{
		case PriorityLow:
		{
			// Stop previous track
			audio_stop_sound(Audio.LowTrack[0]);
			
			Audio.LowTrack[0] = audio_play_sound(soundid, 0, false);
			Audio.LowTrack[1] = looppoint == other ? Audio.TrackLoop[soundid] : looppoint;
			Audio.LowTrack[2] = EventIdle;
		}
		break;
		case PriorityHigh:
		{
			// Stop previous track
			audio_stop_sound(Audio.HighTrack[0]);

			Audio.HighTrack[0] = audio_play_sound(soundid, 0, false);
			Audio.HighTrack[1] = looppoint == other ? Audio.TrackLoop[soundid] : looppoint;
			Audio.HighTrack[2] = EventIdle;
		}
		break;
	}
	
	// Set track volume
	audio_sound_gain(soundid, Game.MusicVolume, 0);
}