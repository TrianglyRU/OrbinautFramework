function PlayerLevelBound()
{
	// Keep the player inside of stage boundaries using our next position
	if floor(PosX + Xsp) < Stage.LeftBoundary + 16 
	{
		PosX	 = Stage.LeftBoundary + 16;
		Xsp      = 0;
		Inertia  = 0;
	}
	if floor(PosX + Xsp) > Stage.RightBoundary - 24 
	{
		PosX	 = Stage.RightBoundary - 24;
		Xsp      = 0;
		Inertia  = 0;
	}
	
	// Check if player is not in death state
	if !Death
	{
		// Check if player is below bottom stage boundary
		if floor(PosY) > Stage.BottomBoundary and floor(PosY) > Screen.MaxRenderY
		{
			// Reset flags
			Grounded	  = false;
			OnObject	  = false;
			Rolling		  = false;
			Jumping		  = false;
			FlyingState	  = false;
			GlidingState  = false;
			ClimbingState = false;
			
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
			audio_sfx_play(sfxHurt, false, true);
			
			// Set animation
			Animation = AnimDeath;
			
			// Enter death state
			Death = true;
		}
	}
}