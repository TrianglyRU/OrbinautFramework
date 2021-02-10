function StageMusicUpdate()
{	
	// Play stage music
	audio_bgm_play(BackgroundMusic, LoopEnd, LoopStart);
	
	// Music behaviour when got powerup
	if Player.InvincibilityBonus > 0 or Player.HighSpeedBonus > 0
	{	
		// Mute stage music and its DAC channel
		audio_bgm_fadeout(BackgroundMusic, 0);
		
		// Play highspeed bonus music
		if Player.HighSpeedBonus > 0
		{
			audio_bgm_play(HighSpeedPowerup, -1, -1);
		}	
	}
	else
	{	
		// Stop powerup music
		audio_bgm_stop(HighSpeedPowerup, 0);
		
		// Return stage music
		audio_bgm_fadein(BackgroundMusic, 3);
	}
		
	// Stop stage music when act is finished
	if State = ActStateFinished
	{
		audio_bgm_stop(BackgroundMusic, 3);
	}
	
	// Mute DAC channel if main stage music doesn't play at its volume
	if audio_sound_get_gain(BackgroundMusic) != Game.MusicVolume
	{
		audio_bgm_fadeout(BackgroundDAC, 0);
	}
	else
	{
		audio_bgm_fadein(BackgroundDAC, 0);
	}
}