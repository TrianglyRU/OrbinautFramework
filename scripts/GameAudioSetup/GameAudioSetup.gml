function GameAudioLoad()
{
	// Load audiogroups
	audio_group_load(GlobalSFX);
	audio_group_load(BGM);
	
	// Set groups volume to game volume
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM,	    Game.MusicVolume, 0);
	
	// Initialize normal track data
	Game.NormalTrack[TrackEvent]	 = EventIdle;
	Game.NormalTrack[TrackEventTime] = 0;
	Game.NormalTrack[TrackIndex]	 = 0;
	Game.NormalTrack[TrackID]	     = 0;
	Game.NormalTrack[TrackLoop]		 = 0;
	
	// Initialize priority track data
	Game.PriorityTrack[TrackEvent]	   = EventIdle;
	Game.PriorityTrack[TrackEventTime] = 0;
	Game.PriorityTrack[TrackIndex]	   = 0;
	Game.PriorityTrack[TrackID]	       = 0;
	Game.PriorityTrack[TrackLoop]	   = 0;
	
	// Initialize jingle track data
	Game.JingleTrack[TrackEvent]	 = EventIdle;
	Game.JingleTrack[TrackEventTime] = 0;
	Game.JingleTrack[TrackIndex]	 = 0;
	Game.JingleTrack[TrackID]	     = 0;
}