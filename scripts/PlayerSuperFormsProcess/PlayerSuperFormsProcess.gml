function PlayerSuperFormsProcess()
{
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case 1:
		{
			// Start timer
			SuperStateValue++
			
			// Reset speeds
			Inertia = 0;
			Xsp		= 0;
			Ysp		= 0;
		
			// Play animation
			Animation = AnimTransform;
			
			// Disable collisions
			AllowCollision = false;
			
			// Become super after 24 frames
			if SuperStateValue == 25
			{
				// Exit transform animation
				Animation = AnimWalk;
				
				SuperState		= 2;
				SuperStateValue = 1;
				
				AllowCollision = true;
			}				
		}
		break;
		
		// Superform
		case 2:
		{
			// Keep us invincible
			IsInvincible = true;
		
			// Decrease rings
			if Rings
			{
				SuperStateValue++
				
				if SuperStateValue == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			if abs(Inertia) < TopAcc
			{
				SuperStateStar = 0;
			}
			else
			{
				if !SuperStateStar
				{
					SuperStateStar = 12
					instance_create(floor(PosX), floor(PosY), SuperStar);
				}
				else
				{
					SuperStateStar--
				}
			}
			
			// Exit superform
			if !Rings
			{
				SuperStateValue = false;
				SuperState	    = false;
				
				//audio_sfx_play(sfxTransform, false);
				audio_bgm_play(Stage.StageMusic, Stage.StageMusicLooppoint, TypeNormal);
				
				if HighSpeedBonus
				{
					audio_bgm_play(HighspeedMusic, -1, TypePriority);
				}			
			}
		}
		break;
	}
}