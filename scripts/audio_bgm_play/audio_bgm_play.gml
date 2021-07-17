/// @function audio_bgm_play(soundid,looppoint,type)
function audio_bgm_play(soundid, looppoint, type)
{	
	// Restore volume
	audio_sound_gain(soundid, Game.MusicVolume, 0);
	
	switch type
	{
		case TypeNormal:
		{
			audio_stop_sound(Game.NormalTrack[TrackID]);
			
			Game.NormalTrack[TrackEvent] = EventIdle;
			Game.NormalTrack[TrackLoop]  = looppoint;
			Game.NormalTrack[TrackID]    = soundid;
			Game.NormalTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
		case TypePriority:
		{
			audio_stop_sound(Game.PriorityTrack[TrackID]);

			Game.PriorityTrack[TrackEvent] = EventIdle;
			Game.PriorityTrack[TrackLoop]  = looppoint;
			Game.PriorityTrack[TrackID]    = soundid;
			Game.PriorityTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
		case TypeJingle:
		{
			audio_stop_sound(Game.JingleTrack[TrackID]);
			
			Game.JingleTrack[TrackEvent] = EventIdle;
			Game.JingleTrack[TrackID]    = soundid;
			Game.JingleTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
		default: break;
	}
}