function GameAudioReset()
{
	// Reset all sounds and music volume
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM,	    Game.MusicVolume, 0);
	
	// Reset normal track data
	Game.NormalTrack[TrackEvent]	 = EventIdle;
	Game.NormalTrack[TrackEventTime] = 0;
	Game.NormalTrack[TrackIndex]	 = 0;
	Game.NormalTrack[TrackID]	     = 0;
	Game.NormalTrack[TrackLoop]		 = 0;
	
	// Reset priority track data
	Game.PriorityTrack[TrackEvent]	   = EventIdle;
	Game.PriorityTrack[TrackEventTime] = 0;
	Game.PriorityTrack[TrackIndex]	   = 0;
	Game.PriorityTrack[TrackID]	       = 0;
	Game.PriorityTrack[TrackLoop]	   = 0;
	
	// Reset jingle track data
	Game.JingleTrack[TrackEvent]	 = EventIdle;
	Game.JingleTrack[TrackEventTime] = 0;
	Game.JingleTrack[TrackIndex]	 = 0;
	Game.JingleTrack[TrackID]	     = 0;
}