function GameAudioPriorityHandle()
{
	// Get priority track data
	var Track     = Game.PriorityTrack[TrackID];
	var Index     = Game.PriorityTrack[TrackIndex];
	var Loop      = Game.PriorityTrack[TrackLoop];
	var Event     = Game.PriorityTrack[TrackEvent];
	var EventTime = Game.PriorityTrack[TrackEventTime];
	
	if Track
	{
		// Loop
		var Position = audio_sound_get_track_position(Index);
		var Length   = audio_sound_length(Track);
		var Offset   = 41.400 / Length;	
	
		if Position + Offset >= Length and Loop != -1
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
					Game.PriorityTrack[TrackEvent] = EventIdle;
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
					Game.PriorityTrack[TrackID]		   = 0;
					Game.PriorityTrack[TrackIndex]	   = 0;	
					Game.PriorityTrack[TrackLoop]	   = 0;
					Game.PriorityTrack[TrackEventTime] = 0;
					Game.PriorityTrack[TrackEvent]     = EventIdle;
					
					// Stop and reset volume
					audio_stop_sound(Track);
					audio_sound_gain(Track, Game.MusicVolume, 0);
				}
			}
			break;
		}
	}
	
	// Automatic behaviour
	if Track and Event != EventMute and Event != EventStop
	{
		audio_bgm_mute(TypeNormal, 1);
	}
	else if Game.NormalTrack[TrackEvent] == EventMute
	{
		audio_bgm_unmute(TypeNormal, 1);
	}
}