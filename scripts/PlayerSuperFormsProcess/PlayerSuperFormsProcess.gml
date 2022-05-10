function PlayerSuperFormsProcess()
{
	switch SuperState
	{	
		case 1:
		{
			// Reset speeds for 15 frames
			if (++SuperStateValue) < 16
			{
				Gsp = 0;
				Xsp	= 0;
				Ysp	= 0;	
			}
			
			// Restore control on 16th frame
			else if SuperStateValue == 16
			{
				AllowCollision = true;
				AirLock		   = false;
			}
			
			// Become super on 40th (or 37th) frame
			else if SuperStateValue == 40 - (global.Character != CharSonic) * 3
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
		case 2:
		{
			// Decrease ring counter
			if Rings and !Death and !Drown
			{
				if (++SuperStateValue) == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			
			if abs(Gsp) >= TopAcc and !instance_exists(SuperStar)
			{
				// Create star particle
				var  NewObject = instance_create(PosX, PosY, SuperStar);
				with NewObject 
				{
					State = true;
				}
			}
			
			if !Rings
			{	
				// Restore music
				if audio_bgm_is_playing(SuperTheme)
				{
					if Stage.IsBossfight
					{
						audio_bgm_play(AudioPrimary, BossTheme);
					}
					else if HighspeedBonus
					{
						audio_bgm_play(AudioPrimary, HighSpeed);
					}
					else
					{
						audio_bgm_play(AudioPrimary, Stage.StageMusic);
					}					
				}
				
				// Exit super form
				SuperStateValue = false;
				SuperState	    = false;
			}
		}
		break;
	}
}