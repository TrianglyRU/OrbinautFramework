function PlayerGeneralUpdate()
{
	// Handle I-frames timer
	if InvincibilityFrames and !Hurt
	{
		InvincibilityFrames--;
	}
	
	// Handle double spin attack
	if DoubleSpinAttack > -1
	{
		if (++DoubleSpinAttack) > 14
		{
			DoubleSpinAttack = -2;
		}
	}
	
	// Grant extra life for collecting 100 or 200 rings
	if Rings >= LivesRewards[0] and LivesRewards[0] <= 200
	{
		Lives			+= 1;
		LivesRewards[0] += 100;
							
		// Play jungle
		audio_bgm_play(ChannelSecondary, ExtraLife);
	}
	
	// Grant extra life for exceeding 50000 points
	if Score >= LivesRewards[1]
	{
		Lives		    += 1;
		LivesRewards[1] += 50000;
		
		// Play jingle
		audio_bgm_play(ChannelSecondary, ExtraLife);
	}
	
	// Handle highspeed bonus
	if HighspeedBonus
	{	
		if !(--HighspeedBonus)
		{
			if audio_bgm_is_playing(HighSpeed)
			{
				audio_bgm_play(ChannelPrimary, Stage.StageMusic);
			}
		}	
	}
	
	// Handle invincibility bonus
	if InvincibleBonus 
	{
		// Create star particles
		if InvincibleBonus == 1200 and !instance_exists(InvincibilityStar)
		{
			for (var i = 0; i < 8; i++)
			{
				var Object = instance_create(PosX, PosY, InvincibilityStar);
				Object.ID  = i;
			}
		}
		if !(--InvincibleBonus)
		{
			if audio_bgm_is_playing(Invincibility)
			{
				audio_bgm_play(ChannelPrimary, Stage.StageMusic);
			}
		}
	}
}