function PlayerLevelBound()
{
	// Keep the player inside of stage boundaries using our next position
	if floor(PosX + Xsp) < Stage.LeftBoundary + 16 
	{
		if Grounded
		{
			Inertia  = 0;
		}
		Xsp  = 0;
		PosX = Stage.LeftBoundary + 16;
		
	}
	if floor(PosX + Xsp) > Stage.RightBoundary - 24 
	{
		if Grounded
		{
			Inertia  = 0;
		}
		Xsp  = 0;
		PosX = Stage.RightBoundary - 24;
	}
	
	// Check if player is not in death state
	if !Death and !Drown
	{
		// Check if player is below bottom stage boundary
		if floor(PosY) > Stage.DeathBoundary
		{
			// Reset flags
			Grounded	  = false;
			OnObject	  = false;
			Rolling		  = false;
			Jumping		  = false;
			FlyingState	  = false;
			GlidingState  = false;
			ClimbingState = false;
			
			if SuperState
			{
				SuperState = false;
			}
			
			// Destroy barrier
			instance_destroy(Barrier);
			instance_destroy(InvincibilityStar);
			
			// Disable collision and camera
			Screen.CameraEnabled = false;
			AllowCollision		 = false;
			
			// Draw player above everything
			DrawOrder = 0;
			
			// Perform movement
			Inertia = 0;
			Xsp	    = 0;
			Ysp	    = -7;
			Grv	    = 0.21875;
			
			// Play sound
			audio_sfx_play(sfxHurt, false);
			
			// Set animation
			Animation = AnimDeath;
			
			// Enter death state
			Death = true;
		}
	}
}