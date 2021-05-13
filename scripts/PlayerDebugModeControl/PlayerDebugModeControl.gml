function PlayerDebugModeControl()
{
	// Enter of exit debug mode
	if Game.DevMode and Input.CPress
	{
		// Toggle
		DebugMode = !DebugMode;
		
		// Check if we entered debug mode
		if DebugMode
		{
			Xsp		= 0;
			Ysp		= 0;
			Acc		= 0;
			Frc     = 0;
			AirAcc  = 0;
			RollFrc = 0;
			Dec		= 0;
			RollDec = 0;
			Grv		= 0;
			Inertia = 0;
		}
		
		// Check if we exit from debug mode
		else
		{
			Acc		= 0.046875;
			Frc     = 0.046875;
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			Dec		= 0.5;
			RollDec = 0.125;
			Grv		= 0.21875;
			
			AllowCollision = true;
			
			DebugItem  = 0;
			DebugSpeed = 0;
		}
	}
	
	// Exit the code if player is not in debug mode
	if (!DebugMode) exit;
	
	// Force flags
	Death		   = false;
	AllowCollision = false;
	
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
		DebugItem = loop_value_range(DebugItem, 0, array_length(DebugList));
	}
	
	// Spawn current object
	if Input.BPress
	{
		var  objectToSpawn = object_spawn(floor(PosX), floor(PosY), DebugList[DebugItem]);
		with objectToSpawn
		{
			if object_index == Bridge
			{
				object_index.BridgeSprite = spr_obj_bridgelog_gvz;
				object_index.BridgeLength = 6;
			}
		}
	}
}