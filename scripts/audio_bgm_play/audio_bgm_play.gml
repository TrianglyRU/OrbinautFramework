/// @function audio_bgm_play(channelType,soundid)
function audio_bgm_play(channelType,soundid)
{	
	switch channelType
	{
		case TypePrimary:
		{
			audio_stop_sound(Audio.PrimaryTrack[1]);
			audio_sound_gain(soundid, global.MusicVolume, 0);
			
			// Play track
			Audio.PrimaryTrack[0] = EventIdle;
			Audio.PrimaryTrack[1] = audio_play_sound(soundid, 0, false);
			
			// Set loopdata
			if ds_map_exists(Audio.TrackLoop, soundid)
			{
				Audio.PrimaryTrack[3] = Audio.TrackLoop[? soundid];
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
			if ds_map_exists(Audio.SecondChannel, soundid)
			{
				Audio.PrimaryTrack[4] = audio_play_sound(Audio.SecondChannel[? soundid], 0, false);
				
				audio_sound_gain(Audio.SecondChannel[? soundid], global.MusicVolume, 0);
			}
			else
			{
				Audio.PrimaryTrack[4] = noone;
			}
		}
		break;
		case TypeSecondary:
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
			if ds_map_exists(Audio.SecondChannel, soundid)
			{
				Audio.SecondaryTrack[3] = audio_play_sound(Audio.SecondChannel[? soundid], 0, false);
				
				audio_sound_gain(Audio.SecondChannel[? soundid], global.MusicVolume, 0);
			}
			else
			{
				Audio.SecondaryTrack[3] = noone;
			}
		}
		break;
	}
}