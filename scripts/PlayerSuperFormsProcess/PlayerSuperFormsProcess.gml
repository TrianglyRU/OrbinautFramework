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
			
			// Reset speeds for 16 frames
			if SuperStateValue < 16
			{
				Inertia = 0;
				Xsp		= 0;
				Ysp		= 0;	
			}
			
			// Restore inputs on 16th frame
			else if SuperStateValue == 16
			{
				NoControls = false;
			}
			
			// Become super on 40th frame
			else if SuperStateValue == 40
			{
				SuperState		= 2;
				SuperStateValue = 1;
				
				// Exit transform animation if we're still in it
				if Animation == AnimTransform
				{
					Animation = AnimWalk;
				}
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