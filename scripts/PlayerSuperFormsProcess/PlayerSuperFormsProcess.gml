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
			
			// Restore inputs on 16th frame
			else if SuperStateValue == 16
			{
				NoControls = false;
			}
			
			// Become super on 40th (or 37th) frame
			else if SuperStateValue == 40 - (Game.Character != CharSonic) * 3
			{
				if Animation == AnimTransform
				{
					Animation = AnimWalk;
				}
				SuperState		= 2;
				SuperStateValue = 1;
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
				if (++SuperStateValue) == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			
			// Create star particle (and make it follow the player)
			if abs(Inertia) >= TopAcc and !instance_exists(SuperStar)
			{
				var  Object = instance_create(floor(PosX), floor(PosY), SuperStar);
				with Object 
				{
					FollowPlayer = true;
				}
			}
			
			// Exit superform
			if !Rings
			{	
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
				SuperStateValue = false;
				SuperState	    = false;
			}
		}
		break;
	}
}