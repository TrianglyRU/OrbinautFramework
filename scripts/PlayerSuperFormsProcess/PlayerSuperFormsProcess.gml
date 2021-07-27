function PlayerSuperFormsProcess()
{
	/* SuperStateValue is handled automatically, all you have to do is to toggle
	SuperState = true or SuperState = false
	*/
	
	var RingCheck = (Game.DevMode and Rings > 0) or (!Game.DevMode and Rings >= 50)
	
	// Transform
	if !SuperState and !Death and !Drown
	{
		if Jumping and RingCheck and Ysp <= 0 and !SuperStateValue and Input.CPress
		{
			Jumping		    = false;
			SuperState	    = true;
			SuperStateValue = 0;
			
			// Reset invincibility
			InvincibilityBonus = false;
			
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			
			audio_sfx_play(sfxTransform, false);
			
			audio_bgm_stop(TypePriority, 1);
			audio_bgm_play(SuperTheme, 0.6, TypeNormal);
		}
	}
	
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
			if !Rings or (Game.DevMode and Jumping and Input.CPress)
			{
				SuperStateValue = 0;
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