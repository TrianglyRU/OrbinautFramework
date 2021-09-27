/// @function audio_bgm_play(priority,soundid,loopstart,loopend)
function audio_bgm_play(priority,soundid,loopstart,loopend)
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
			Audio.LowTrack[2] = EventIdle;
			
			// Set looppoints
			if loopstart == other
			{
				Audio.LowTrack[1][0] = Audio.TrackLoop[soundid][0];
			}
			else
			{
				Audio.LowTrack[1][0] = loopstart;
			}
			if loopend == other
			{
				Audio.LowTrack[1][1] = Audio.TrackLoop[soundid][1];
			}
			else
			{
				Audio.LowTrack[1][1] = loopend;
			}
		}
		break;
		case PriorityHigh:
		{
			// Stop previous track
			audio_stop_sound(Audio.HighTrack[0]);

			Audio.HighTrack[0] = audio_play_sound(soundid, 0, false);
			Audio.HighTrack[2] = EventIdle;
		}
		break;
	}
	
	// Set track volume
	audio_sound_gain(soundid, Game.MusicVolume, 0);
}