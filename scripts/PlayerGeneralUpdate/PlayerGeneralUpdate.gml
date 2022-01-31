function PlayerGeneralUpdate()
{
	// Handle inv-frames timer
	if InvincibilityFrames and !Hurt
	{
		InvincibilityFrames--;
	}
	
	// Handle double spin attack timer
	if DoubleSpinAttack > SpinReady
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
				audio_bgm_play(TypePrimary, Stage.StageMusic);
			}
		}	
	}
	
	// Handle invincibility bonus timer
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
				audio_bgm_play(TypePrimary, Stage.StageMusic);
			}
		}
	}
	
	// Grant extra life for collecting 100 or 200 rings
	if Rings >= LivesRewards[0] and LivesRewards[0] <= 200
	{
		Lives			+= 1;
		LivesRewards[0] += 100;
							
		audio_bgm_play(TypeSecondary, ExtraLife);
	}
	
	// Grant extra life for exceeding 50000 points
	if Score >= LivesRewards[1]
	{
		Lives		    += 1;
		LivesRewards[1] += 50000;
		
		audio_bgm_play(TypeSecondary, ExtraLife);
	}
}