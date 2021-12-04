function PlayerDebugMode()
{
	// Exit if not in devmode or stage is inactive (but procees if player died)
	if !Game.DevMode or !(Player.Death or Stage.DoUpdate) 
	{
		return false;
	}
	
	// Exit if player has died and fell off-screen
	if Player.Death and floor(Player.PosY) >= Camera.ViewY + Game.Height
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
			AllowCollision   = false;
			Grounded	     = false;
			OnObject	     = false;
			GroundLock       = false;
			AirLock	         = false;
			FlightState      = false;
			ClimbState	     = false;
			GlideState	     = false;
			Jumping		     = false;
			Spinning	     = false;
			StickToConvex    = false;
			IsUnderwater     = false;
			DebugSpeed       = 0;
			Xsp			     = 0;
			Ysp			     = 0;
			Inertia		     = 0;
			SpindashRev      = -1;
			PeeloutRev       = -1;
			DropdashRev      = -1;
			DropdashFlag	 = -1;
			DoubleSpinAttack = -1;
			
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
				if audio_bgm_is_playing(Drowning) or !audio_bgm_is_playing(ChannelPrimary)
				{
					audio_bgm_play(ChannelPrimary, Stage.StageMusic);
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
			
			// Stop player sfx
			audio_sfx_stop(sfxFlying);
			audio_sfx_stop(sfxTired);
		}
		else
		{
			// Reset collision
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
			var  ThisObject = image_xscale;
			var  Object     = instance_create(PosX, PosY, DebugList[DebugItem]);
			with Object
			{
				// Spawn with the same xscale
				image_xscale = ThisObject;
					
				// Delete object onc off-screen
				object_set_unload(TypeDelete);
			}
		}
		
		// Switch to previous object in the list
		else
		{
			DebugItem = loop_value(DebugItem - 1, 0, array_length(DebugList));
		}
	}
}