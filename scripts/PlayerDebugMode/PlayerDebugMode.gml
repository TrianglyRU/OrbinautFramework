function PlayerDebugMode()
{
	// Check if we're in dev mode
	if !Game.DevMode
	{
		return false;
	}

	// Exit if stage is paused
	if Stage.IsPaused
	{
		return false;
	}
	
	// Check for entering for exiting debug mode
	if Input.BPress
	{
		if Death
		{
			Screen.CameraEnabled = true;
			Stage.AllowPause     = true;
			Stage.DoUpdate       = true;
			AllowCollision       = true;
			
			DrawOrder = layer_get_depth("Objects");
			Death = false;
		}
		
		// Toggle debug
		DebugMode = !DebugMode;

		// Check if we entered debug
		if DebugMode
		{
			// Reset flags. A lot of it
			AllowCollision = false;
			Grounded	   = false;
			OnObject	   = false;
			MovementLock   = false;
			NoControls	   = false;
			FlightState    = false;
			FlightValue    = false;
			ClimbState	   = false;
			ClimbValue	   = false;
			GlideState	   = false;
			GlideGrounded  = false;
			GlideValue     = false;
			Jumping		   = false;
			Spinning		   = false;
			RollJumping	   = false;
			Skidding	   = false;
			StickToConvex  = false;
			IsUnderwater   = false;
			AirTimer	   = 1800;
			DebugSpeed     = 0;
			Xsp			   = 0;
			Ysp			   = 0;
			Inertia		   = 0;
			SpindashRev    = -1;
			PeeloutRev     = -1;
			DropdashRev    = -1;
			
			// Reset gravity
			if !IsUnderwater
			{
				Grv	= 0.21875;
			}
			else
			{
				// Lower by 0x28 (0.15625) if underwater
				Grv = 0.0625
			}
			
			// Restore visibility
			image_alpha = 1;
		}
		
		// Check if we exited debug
		else
		{
			// Enter walk animation
			RadiusX   = DefaultRadiusX;
			RadiusY   = DefaultRadiusY;
			
			Animation = AnimWalk;
			
			// Restore collision
			AllowCollision = true;
		}
	}
	
	// Check if we're in debug state
	if !DebugMode
	{
		return false;
	}
	
	// Increase speed
	if Input.Left or Input.Down or Input.Right or Input.Up
	{
		DebugSpeed = min(DebugSpeed + 0.046875, 16);
	}
	else
	{
		DebugSpeed = 0;
	}
	
	// Update player position
	if (Input.Left)  PosX -= DebugSpeed;
	if (Input.Right) PosX += DebugSpeed;
	if (Input.Up)    PosY -= DebugSpeed;
	if (Input.Down)  PosY += DebugSpeed;
	
	// Update current object
	if Input.APress
	{
		DebugItem++;
		DebugItem = loop_value(DebugItem, 0, array_length(DebugList));
	}
	
	// Spawn current object
	if Input.CPress
	{
		instance_create(floor(PosX), floor(PosY), DebugList[DebugItem]);
	}
	
	return true;
}