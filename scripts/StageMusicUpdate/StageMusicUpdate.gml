function StageMusicUpdate()
{	
	/* StageMusic, StageMusicDAC, LoopEnd and LoopStart 
	variables are set in StageActSetup */
	
	// Don't bother do anything if volume is zero
	if (Game.MusicVolume == 0) exit;

	// Play stage music
	if StageMusic != noone
	{
		audio_bgm_play(StageMusic, LoopEnd, LoopStart);
	}
	
	// Check if act is in its normal state
	if State != ActStateFinished and State != ActStateUnload and State != ActStateRestart
	{
		// Music behaviour when got speedup powerup
		if Player.HighSpeedBonus > 0
		{
			// Mute stage music 
			audio_bgm_mute(StageMusic, 0);
			
			// Play speedup powerup
			audio_bgm_play(SpeedupPowerup, -1, -1);
		}
		else
		{	
			// Stop highspeed powerup music
			audio_bgm_stop(SpeedupPowerup, 0.5);
		
			// Return stage music
			audio_bgm_fadein(StageMusic, 0.5);
		}
		
		// Music behaviour when got invincible powerup
		if Player.InvincibilityBonus > 0
		{
			// Mute stage music 
			audio_bgm_mute(StageMusic, 0);
			
			// Mute highspeed music
			audio_bgm_mute(SpeedupPowerup, 0.5);
			
			// Play invincible powerup
			audio_bgm_fadein(InvinciblePowerup, 0);
			audio_bgm_play(InvinciblePowerup, -1, -1);
		}
		else
		{	
			// Stop invincible powerup music
			audio_bgm_stop(InvinciblePowerup, 0.5);
		
			// Return stage music
			if Player.HighSpeedBonus
			{
				audio_bgm_fadein(SpeedupPowerup, 0.5);
			}
			else
			{
				audio_bgm_fadein(StageMusic, 0.5);
			}
		}
	}
	
	// Stop music after 1-second fade
	else
	{
		audio_bgm_stop(StageMusic,	      1);
		audio_bgm_stop(SpeedupPowerup,    1);
		audio_bgm_stop(InvinciblePowerup, 1);
	}

	// Mute DAC channel if main stage music doesn't play at its volume
	if StageMusicDAC != noone 
	{
		if audio_sound_get_gain(StageMusic) != Game.MusicVolume
		{
			audio_bgm_mute(StageMusicDAC, 0);
		}
		else
		{
			audio_bgm_fadein(StageMusicDAC, 0);
		}
	}
}