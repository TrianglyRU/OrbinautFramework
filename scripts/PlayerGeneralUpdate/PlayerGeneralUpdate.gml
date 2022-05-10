function PlayerGeneralUpdate()
{
	// Handle inv-frames timer
	if InvincibilityFrames and !Hurt
	{
		InvincibilityFrames--;
	}
	
	// Handle double spin attack timer
	if DoubleSpinAttack > SpinReady		// SpinReady is -1, so > -1
	{
		if (++DoubleSpinAttack) > 14
		{
			DoubleSpinAttack = SpinRecharge;
		}
	}
	
	// Handle highspeed bonus timer
	if HighspeedBonus
	{	
		if !(--HighspeedBonus)
		{
			if audio_bgm_is_playing(HighSpeed)
			{
				audio_bgm_play(AudioPrimary, Stage.StageMusic);
			}
		}	
	}
	
	// Handle invincibility bonus timer
	if InvincibleBonus 
	{
		if !(--InvincibleBonus)
		{
			if audio_bgm_is_playing(Invincibility)
			{
				audio_bgm_play(AudioPrimary, Stage.StageMusic);
			}
		}
	}
	
	// Grant extra life for collecting 100 or 200 rings
	if Rings >= LivesRewards[0] and LivesRewards[0] <= 200
	{
		Lives			+= 1;
		LivesRewards[0] += 100;
							
		audio_bgm_play(AudioSecondary, ExtraLife);
	}
	
	// Grant extra life for exceeding 50000 points
	if Score >= LivesRewards[1]
	{
		Lives		    += 1;
		LivesRewards[1] += 50000;
		
		audio_bgm_play(AudioSecondary, ExtraLife);
	}
}