function GameAudioNormalProcess()
{
	// Get normal track data
	var Track     = Game.NormalTrack[TrackID];
	var Index     = Game.NormalTrack[TrackIndex];
	var Loop      = Game.NormalTrack[TrackLoop];
	var Event     = Game.NormalTrack[TrackEvent];
	var EventTime = Game.NormalTrack[TrackEventTime];
	
	// Exit if channel is inactive
	if !Track
	{
		exit;
	}
	
	// Loop
	var Position = audio_sound_get_track_position(Index);
	var Length   = audio_sound_length(Track);
	var Offset   = 41.400 / Length;	
	
	if Position + 0.1 >= Length and Loop != -1
	{
		audio_sound_set_track_position(Index, Loop);
	}
		
	// Check what track should do
	switch Event
	{
		// If idle, don't do anything
		case EventIdle: break;
			
		// Unmute
		case EventUnmute:
		{
			// Get the volume step
			var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
			// Set the target volume
			var VolumeLevel = min(audio_sound_get_gain(Track) + VolumeStep, Game.MusicVolume);
	
			// Update BGM volume
			audio_sound_gain(Track, VolumeLevel, 0);
				
			// Check if track volume is music volume
			if audio_sound_get_gain(Track) == Game.MusicVolume
			{
				// Reset event
				Game.NormalTrack[TrackEvent] = EventIdle;
			}
		}
		break;
			
		// Mute
		case EventMute:
		{
			// Get the volume step
			var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
			// Set the target volume
			var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
			// Update BGM volume
			audio_sound_gain(Track, VolumeLevel, 0);
		}
		break;
			
		// Stop
		case EventStop:
		{
			// Get the volume step
			var VolumeStep = Game.MusicVolume / (EventTime * 60);
	
			// Set the target volume
			var VolumeLevel = max(audio_sound_get_gain(Track) - VolumeStep, 0);
	
			// Update BGM volume
			audio_sound_gain(Track, VolumeLevel, 0);
				
			// Check if track volume is 0 and we stop the bgm
			if audio_sound_get_gain(Track) == 0
			{		
				// Clear data
				Game.NormalTrack[TrackID]		 = 0;
				Game.NormalTrack[TrackIndex]	 = 0;	
				Game.NormalTrack[TrackLoop]		 = 0;
				Game.NormalTrack[TrackEventTime] = 0;
				Game.NormalTrack[TrackEvent]	 = EventIdle;
					
				// Stop and reset volume
				audio_stop_sound(Track);
				audio_sound_gain(Track, Game.MusicVolume, 0);
			}
		}
	}
}