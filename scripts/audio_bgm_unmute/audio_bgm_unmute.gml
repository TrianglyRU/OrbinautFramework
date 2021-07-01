/// @function audio_bgm_unmute(type,time)
function audio_bgm_unmute(type, time)
{	
	switch type
	{
		case TypeNormal:
			Game.NormalTrack[TrackEvent]	   = EventUnmute;
			Game.NormalTrack[TrackEventTime]   = time;
		break;
		case TypePriority:
			Game.PriorityTrack[TrackEvent]	   = EventUnmute;
			Game.PriorityTrack[TrackEventTime] = time;
		break;
		case TypeJingle:
			Game.JingleTrack[TrackEvent]	   = EventUnmute;
			Game.JingleTrack[TrackEventTime]   = time;
		break;
		case TypeAll:
		{
			Game.NormalTrack[TrackEvent]	   = EventUnmute;
			Game.PriorityTrack[TrackEvent]	   = EventUnmute;
			Game.JingleTrack[TrackEvent]	   = EventUnmute;
			Game.NormalTrack[TrackEventTime]   = time;
			Game.PriorityTrack[TrackEventTime] = time;
			Game.JingleTrack[TrackEventTime]   = time;
		}
		break;
	}
}