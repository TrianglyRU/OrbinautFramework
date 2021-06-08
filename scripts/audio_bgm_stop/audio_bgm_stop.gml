/// @function audio_bgm_stop(type,time)
function audio_bgm_stop(type, time)
{	
	switch type
	{
		case TypeNormal:
			Game.NormalTrack[TrackEvent]	   = EventStop;
			Game.NormalTrack[TrackEventTime]   = time;
		break;
		case TypePriority:
			Game.PriorityTrack[TrackEvent]	   = EventStop;
			Game.PriorityTrack[TrackEventTime] = time;
		break;
		case TypeJingle:
			Game.JingleTrack[TrackEvent]	   = EventStop;
			Game.JingleTrack[TrackEventTime]   = time;
		break;
		case TypeAll:
		{
			Game.NormalTrack[TrackEvent]	   = EventStop;
			Game.PriorityTrack[TrackEvent]	   = EventStop;
			Game.JingleTrack[TrackEvent]	   = EventStop;
			Game.NormalTrack[TrackEventTime]   = time;
			Game.PriorityTrack[TrackEventTime] = time;
			Game.JingleTrack[TrackEventTime]   = time;
		}
		break;
	}
}