function StageMusicUpdate()
{	
	/* StageMusic, StageMusicDAC, LoopEnd and LoopStart 
	variables are set in StageActSetup */

	// Start playing stage music
	if StageMusic != noone and State == ActStateLoading
	{
		audio_bgm_play(StageMusic);
	}
	
	// Loop stage music
	audio_bgm_loop(StageMusic, LoopEnd, LoopStart);
	
	// Music behaviour when got powerup
	if Player.InvincibilityBonus > 0 or Player.HighSpeedBonus > 0
	{	
		// Mute stage music 
		audio_bgm_fadeout(StageMusic, 1);

		// Play highspeed bonus music
		if Player.HighSpeedBonus > 0
		{
			audio_bgm_play(HighSpeedPowerup);
		}	
	}
	else
	{	
		// Stop powerup music
		audio_bgm_stop(HighSpeedPowerup, 0);
		
		// Return stage music
		audio_bgm_fadein(StageMusic, 3);
	}
		
	// Stop stage music when act is finished
	if State == ActStateFinished or State == ActStateUnload
	{
		audio_bgm_stop(StageMusic, 3);
	}
	
	// Mute DAC channel if main stage music doesn't play at its volume
	if StageMusicDAC != noone 
	{
		if audio_sound_get_gain(StageMusic) != Game.MusicVolume
		{
			audio_bgm_fadeout(StageMusicDAC, 0);
		}
		else
		{
			audio_bgm_fadein(StageMusicDAC, 0);
		}
	}	
}