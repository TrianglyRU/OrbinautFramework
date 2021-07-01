/// @function audio_bgm_mute(type,time)
function audio_bgm_mute(type, time)
{
	switch type
	{
		case TypeNormal:
			Game.NormalTrack[TrackEvent]	   = EventMute;
			Game.NormalTrack[TrackEventTime]   = time;
		break;
		case TypePriority:
			Game.PriorityTrack[TrackEvent]	   = EventMute;
			Game.PriorityTrack[TrackEventTime] = time;
		break;
		case TypeJingle:
			Game.JingleTrack[TrackEvent]	   = EventMute;
			Game.JingleTrack[TrackEventTime]   = time;
		break;
		case TypeAll:
		{
			Game.NormalTrack[TrackEvent]	   = EventMute;
			Game.PriorityTrack[TrackEvent]	   = EventMute;
			Game.JingleTrack[TrackEvent]	   = EventMute;
			Game.NormalTrack[TrackEventTime]   = time;
			Game.PriorityTrack[TrackEventTime] = time;
			Game.JingleTrack[TrackEventTime]   = time;
		}
		break;
	}
}