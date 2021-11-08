function PlayerGeneralUpdate()
{
	// Decrease invincibility frames timer
	if InvincibilityFrames and !Hurt
	{
		InvincibilityFrames--;
	}
	
	// Grant extra life
	if Rings >= 100 and LivesRewards == 0 or Rings >= 200 and LivesRewards == 1
	{
		Lives++;
		LivesRewards++;
							
		// Play jungle
		audio_bgm_play(PriorityHigh, ExtraLife);
	}
	
	// Handle highspeed bonus
	if HighspeedBonus
	{	
		if !(--HighspeedBonus)
		{
			if audio_bgm_is_playing(HighSpeed)
			{
				audio_bgm_play(PriorityLow, Stage.StageMusic);
			}
		}	
	}
	
	// Handle invincibility bonus
	if InvincibleBonus 
	{
		// Create star particles
		if InvincibleBonus == 1200 and !instance_exists(InvincibilityStar)
		{
			for (var i = 1; i < 9; i++)
			{
				var Object = instance_create(PosX, PosY, InvincibilityStar);
					Object.ID = i;
			}
			with InvincibilityStar 
			{
				animation_play(ID mod 2 ? spr_obj_invstar_type1 : spr_obj_invstar_type2, 1, ID, 0);
			}
		}
		if !(--InvincibleBonus)
		{
			if audio_bgm_is_playing(Invincibility)
			{
				audio_bgm_play(PriorityLow, Stage.StageMusic);
			}
		}
	}
}