function PlayerDebugMode()
{
	// Exit if not in devmode or stage is paused
	if !Game.DevMode or Stage.IsPaused
	{
		return false;
	}
	
	// Exit if died and fallen off-screen
	if Player.Death and floor(Player.PosY) >= Camera.ViewY + Game.Height + 32
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
			GroundLock     = false;
			AirLock	       = false;
			FlightState    = false;
			FlightValue    = false;
			ClimbState	   = false;
			ClimbValue	   = false;
			GlideState	   = false;
			GlideGrounded  = false;
			GlideValue     = false;
			Jumping		   = false;
			Spinning	   = false;
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
			
			// Set animation
			Animation   = AnimMove;
			image_alpha = 1;
		}
		else
		{
			// Reset collision radiuses
			RadiusX	= DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			AllowCollision = true;
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
	
	// Switch to next object in the list
	if Input.APress
	{
		DebugItem = loop_value(DebugItem + 1, 0, array_length(DebugList));
	}
	if Input.CPress
	{
		// Spawn current object
		if !Input.A
		{
			if DebugList[DebugItem] != Player
			{
				var  ThisObject = image_xscale;
				var  Object     = instance_create(PosX, PosY, DebugList[DebugItem]);
				with Object
				{
					// Spawn with the same xscale
					image_xscale = ThisObject;
					
					// Delete when off-screen
					object_set_range(TypeDelete);
				}
			}
			
			// Grant or revoke 7 emeralds
			else
			{
				if !Game.Emeralds
				{
					Game.Emeralds = 7;
					audio_sfx_play(sfxEmerald, false);
				}
				else
				{
					Game.Emeralds = 0;
					audio_sfx_play(sfxFail, false);
				}
			}
		}
		
		// Switch to previous object in the list
		else
		{
			DebugItem = loop_value(DebugItem - 1, 0, array_length(DebugList));
		}
	}
}