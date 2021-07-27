function PlayerDebugMode()
{
	// Check if we're in dev mode
	if !Game.DevMode or Death
	{
		exit;
	}
	
	// Exit if stage is paused
	if Stage.GamePaused
	{
		exit;
	}
	
	// Check for entering for exiting debug mode
	if Input.BPress
	{
		// Toggle debug
		DebugMode = !DebugMode;

		// Check if we entered debug
		if DebugMode
		{
			// Reset flags
			AllowCollision = false;
			Grounded	   = false;
			OnObject	   = false;
			MovementLock   = false;
			FlightState    = false;
			FlightValue    = false;
			ClimbState	   = false;
			ClimbValue	   = false;
			GlideState	   = false;
			GlideGrounded  = false;
			GlideValue     = false;
			DebugSpeed     = 0;
			Xsp			   = 0;
			Ysp			   = 0;
			Inertia		   = 0;
			SpindashRev    = -1;
			PeeloutRev     = -1;
			DropdashRev    = -1;
			
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
		exit;
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
	if Input.CPress
	{
		DebugItem++;
		DebugItem = loop_value(DebugItem, 0, array_length(DebugList));
	}
	
	// Spawn current object
	if Input.APress
	{
		instance_create(floor(PosX), floor(PosY), DebugList[DebugItem]);
	}
}