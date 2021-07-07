/// @function audio_bgm_unmute(type,time)
function audio_bgm_unmute(type, time)
{	
	switch type
	{
		case TypeNormal:
		{
			Game.NormalTrack[TrackEvent]	 = EventPlay;
			Game.NormalTrack[TrackEventTime] = time;
		}
		break;
		case TypePriority:
		{
			Game.PriorityTrack[TrackEvent]	   = EventPlay;
			Game.PriorityTrack[TrackEventTime] = time;
		}
		break;
		case TypeJingle:
		{
			Game.JingleTrack[TrackEvent]	   = EventPlay;
			Game.JingleTrack[TrackEventTime]   = time;
		}
		break;
		case TypeAll:
		{
			Game.NormalTrack[TrackEvent]	   = EventPlay;
			Game.PriorityTrack[TrackEvent]	   = EventPlay;
			Game.JingleTrack[TrackEvent]	   = EventPlay;
			Game.NormalTrack[TrackEventTime]   = time;
			Game.PriorityTrack[TrackEventTime] = time;
			Game.JingleTrack[TrackEventTime]   = time;
		}
		break;
	}
}