/// @function audio_bgm_play(channelType,soundid)
function audio_bgm_play(channelType,soundid)
{	
	// Exit if no audio set
	if !soundid
	{
		exit;
	}
	
	// Play new track
	switch channelType
	{
		case ChannelPrimary:
		{
			// Stop previous track
			audio_stop_sound(Audio.PrimaryTrack[1]);
			
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
		}
		break;
		case ChannelSecondary:
		{
			// Stop previous track
			audio_stop_sound(Audio.SecondaryTrack[1]);

			Audio.SecondaryTrack[0] = EventIdle;
			Audio.SecondaryTrack[1] = audio_play_sound(soundid, 0, false);
		}
		break;
	}
	
	// Set track volume
	audio_sound_gain(soundid, Game.MusicVolume, 0);
}