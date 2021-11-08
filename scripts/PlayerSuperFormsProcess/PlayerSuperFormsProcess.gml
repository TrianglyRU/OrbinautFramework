function PlayerSuperFormsProcess()
{
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case 1:
		{
			// Count timer
			SuperStateValue++
			
			// Reset speeds for 16 frames
			if SuperStateValue < 16
			{
				Inertia = 0;
				Xsp		= 0;
				Ysp		= 0;	
			}
			
			// Restore control on 16th frame
			else if SuperStateValue == 16
			{
				AirLock = false;
			}
			
			// Become super on 40th (or 37th) frame
			else if SuperStateValue == 40 - (Game.Character != CharSonic) * 3
			{
				if Animation == AnimTransform
				{
					Animation = AnimMove;
				}
				SuperState		= 2;
				SuperStateValue = 1;
			}				
		}
		break;
		
		// Superform
		case 2:
		{
			// Decrease rings
			if Rings and !Death and !Drown
			{
				if (++SuperStateValue) == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			
			// Create star particle (and make it follow the player)
			if abs(Inertia) >= TopAcc and !instance_exists(SuperStar)
			{
				var  Object = instance_create(PosX, PosY, SuperStar);
				with Object 
				{
					FollowPlayer = true;
				}
			}
			
			// Exit superform
			if !Rings
			{	
				if audio_bgm_is_playing(SuperTheme)
				{
					if Stage.IsBossfight
					{
						audio_bgm_play(PriorityLow, Boss);
					}
					else if HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighSpeed);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic);
					}					
				}
				SuperStateValue = false;
				SuperState	    = false;
			}
		}
		break;
	}
}