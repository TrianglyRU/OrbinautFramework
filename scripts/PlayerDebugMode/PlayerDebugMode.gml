function PlayerDebugMode()
{
	// Exit if not in devmode or stage is paused
	if !Game.DevMode or Stage.IsPaused
	{
		return false;
	}

	if Input.BPress
	{
		// Toggle debug mode upon pressing B key
		DebugMode = !DebugMode;
		
		// Reset flags. A lot of it
		if DebugMode
		{
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
			Spinning	   = false;
			RollJumping	   = false;
			Skidding	   = false;
			StickToConvex  = false;
			IsUnderwater   = false;
			DebugSpeed     = 0;
			Xsp			   = 0;
			Ysp			   = 0;
			Inertia		   = 0;
			SpindashRev    = -1;
			PeeloutRev     = -1;
			DropdashRev    = -1;
			
			// Cancel death event
			if (Death or Drown) and floor(Player.PosY) < Camera.ViewY + Game.Height
			{
				DrawOrder		  = layer_get_depth("Objects");
				Death		      = false;
				Drown             = false;
				Camera.Enabled    = true;
				Stage.AllowPause  = true;
				Stage.DoUpdate    = true;
				Stage.TimeEnabled = true;
			}
			
			// Reset air timer and restore music
			if AirTimer <= 720
			{
				if audio_bgm_is_playing(DrowningMusic) or !audio_bgm_is_playing(PriorityLow)
				{
					audio_bgm_play(PriorityLow, Stage.StageMusic, other);
				}
			}
			AirTimer = 1800;
			
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
		else
		{
			// Reset collision radiuses
			RadiusX	= DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			
			// Restore collision and set animation
			AllowCollision = true;
			Animation      = AnimMove;
		}
	}
	
	// Check if we're in debug state
	if !DebugMode
	{
		exit;
	}
	
	// Update speed
	if Input.Left or Input.Down or Input.Right or Input.Up
	{
		DebugSpeed = min(DebugSpeed + 0.046875, 16);
	}
	else
	{
		DebugSpeed = 0;
	}
	
	// Update position
	if Input.Left
	{
		PosX -= DebugSpeed;
	}
	if Input.Right
	{
		PosX += DebugSpeed;
	}
	if Input.Up    
	{
		PosY -= DebugSpeed;
	}
	if Input.Down
	{
		PosY += DebugSpeed;
	}
	
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
}