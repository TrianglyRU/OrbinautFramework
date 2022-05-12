/// @function audio_bgm_play(audioType,soundid)
function audio_bgm_play(audioType,soundid)
{	
	switch audioType
	{
		case AudioPrimary:
		{
			audio_stop_sound(Audio.PrimaryTrack[1]);
			audio_sound_gain(soundid, global.MusicVolume, 0);
			
			// Play track
			Audio.PrimaryTrack[0] = EventIdle;
			Audio.PrimaryTrack[1] = audio_play_sound(soundid, 0, false);
			
			// Set loopdata
			if ds_map_exists(Audio.TrackLoopData, soundid)
			{
				Audio.PrimaryTrack[3] = Audio.TrackLoopData[? soundid];
			}
			else
			{
				Audio.PrimaryTrack[3] = [];
			}
			
			// Play second channel if assigned
			if Audio.PrimaryTrack[4]
			{
				audio_stop_sound(Audio.PrimaryTrack[4]);
			}
			if ds_map_exists(Audio.SubTrackData, soundid)
			{
				Audio.PrimaryTrack[4] = audio_play_sound(Audio.SubTrackData[? soundid], 0, false);
				
				audio_sound_gain(Audio.SubTrackData[? soundid], global.MusicVolume, 0);
			}
			else
			{
				Audio.PrimaryTrack[4] = noone;
			}
		}
		break;
		case AudioSecondary:
		{
			audio_stop_sound(Audio.SecondaryTrack[1]);
			audio_sound_gain(soundid, global.MusicVolume, 0);

			// Play track
			Audio.SecondaryTrack[0] = EventIdle;
			Audio.SecondaryTrack[1] = audio_play_sound(soundid, 0, false);
			
			// Play second channel if assigned
			if Audio.SecondaryTrack[3]
			{
				audio_stop_sound(Audio.SecondaryTrack[3]);
			}
			if ds_map_exists(Audio.SubTrackData, soundid)
			{
				Audio.SecondaryTrack[3] = audio_play_sound(Audio.SubTrackData[? soundid], 0, false);
				
				audio_sound_gain(Audio.SubTrackData[? soundid], global.MusicVolume, 0);
			}
			else
			{
				Audio.SecondaryTrack[3] = noone;
			}
		}
		break;
	}
}