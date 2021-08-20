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
			
			// Become super on 40th (or 37th) frame
			else if SuperStateValue == 40 - (CharacterID != CharSonic) * 3
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
			if Rings and !Death and !Drown
			{
				SuperStateValue++
				
				if SuperStateValue == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			
			// Create first super star (and make it follow the player)
			if abs(Inertia) >= TopAcc and !instance_exists(SuperStar)
			{
				var  CreatedStar = instance_create(floor(PosX), floor(PosY), SuperStar);
				with CreatedStar 
				{
					FollowPlayer = true;
				}
			}
			
			// Exit superform
			if !Rings
			{
				SuperStateValue = false;
				SuperState	    = false;
				
				if audio_bgm_is_playing(SuperMusic)
				{
					if Stage.IsBossfight
					{
						audio_bgm_play(PriorityLow, BossMusic, other);
					}
					else if HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighspeedMusic, noone);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic, other);
					}					
				}
			}
		}
		break;
	}
}