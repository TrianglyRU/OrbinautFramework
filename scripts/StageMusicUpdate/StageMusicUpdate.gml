function StageMusicUpdate()
{	
	// Play stage music
	sound_bgm_play(BackgroundMusic, LoopEnd, LoopStart);
	
	// Music behaviour when got powerup
	if Player.InvincibilityBonus > 0 or Player.HighSpeedBonus > 0
	{	
		// Mute stage music and its DAC channel
		sound_bgm_fadeout(BackgroundMusic, 0);
		
		// Play highspeed bonus music
		if Player.HighSpeedBonus > 0
		{
			sound_bgm_play(HighSpeedPowerup, -1, -1);
		}	
	}
	else
	{	
		// Stop powerup music
		sound_bgm_stop(HighSpeedPowerup, 0);
		
		// Return stage music
		sound_bgm_fadein(BackgroundMusic, 3);
	}
		
	// Stop stage music when act is finished
	if State = ActStateFinished
	{
		sound_bgm_stop(BackgroundMusic, 3);
	}
	
	// Mute DAC channel if main stage music doesn't play at its volume
	if audio_sound_get_gain(BackgroundMusic) != Game.MusicVolume
	{
		sound_bgm_fadeout(BackgroundDAC, 0);
	}
	else
	{
		sound_bgm_fadein(BackgroundDAC, 0);
	}
}