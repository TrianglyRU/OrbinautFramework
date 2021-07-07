/// @function audio_bgm_play(soundid,dacid,looppoint,type)
function audio_bgm_play(soundid, dacid, looppoint, type)
{	
	if audio_is_playing(soundid)
	{
		exit;
	}
	
	switch type
	{
		case TypeNormal:
		{
			audio_stop_sound(Game.NormalTrack[TrackID]);
			
			if Game.NormalTrack[TrackEvent] != EventMute
			{
				audio_sound_gain(soundid, Game.MusicVolume, 0);
			}
		
			Game.NormalTrack[TrackEvent] = EventPlay;
			Game.NormalTrack[TrackID]    = soundid;
			Game.NormalTrack[TrackLoop]  = looppoint;
			Game.NormalTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
		case TypePriority:
		{
			audio_stop_sound(Game.PriorityTrack[TrackID]);
		
			if Game.PriorityTrack[TrackEvent] != EventMute
			{
				audio_sound_gain(soundid, Game.MusicVolume, 0);
			}
			
			Game.PriorityTrack[TrackEvent] = EventPlay;
			Game.PriorityTrack[TrackID]    = soundid;
			Game.PriorityTrack[TrackLoop]  = looppoint;
			Game.PriorityTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
		case TypeJingle:
		{
			audio_stop_sound(Game.JingleTrack[TrackID]);
			
			if Game.JingleTrack[TrackEvent] != EventMute
			{
				audio_sound_gain(soundid, Game.MusicVolume, 0);
			}
			
			Game.JingleTrack[TrackEvent] = EventPlay;
			Game.JingleTrack[TrackID]    = soundid;
			Game.JingleTrack[TrackIndex] = audio_play_sound(soundid, 0, false);
		}
		break;
	}
}