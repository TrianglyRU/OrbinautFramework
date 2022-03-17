function PlayerDebugMode()
{
	if !global.DevMode or Stage.IsPaused or fade_check(StateActive)
	{
		return false;
	}
	if (Death or Drown) and floor(PosY) > Camera.ViewY + global.Height 
	{
		return false;
	}

	// Toggle Edit Mode
	if Input.BPress
	{
		if !DebugMode
		{
			DebugMode        = true;
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
			Death		     = false;
			Drown            = false;
			AirTimer		 = 1800;
			DropdashRev      = -1;
			SpindashRev      = -1;
			PeeloutRev       = -1;
			DebugSpeed       =  0;
			Xsp			     =  0;
			Ysp			     =  0;
			Gsp				 =  0;
			DoubleSpinAttack = SpinRecharge;
			DropdashFlag	 = DashLocked;
			Camera.Enabled   = true;
			
			audio_sfx_stop(sfxFlying);
			audio_sfx_stop(sfxTired);
			
			image_alpha = 1;
			depth		= DrawOrder;
			
			// Reset music
			if audio_bgm_is_playing(Drowning) or !audio_bgm_is_playing(AudioPrimary)
			{
				audio_bgm_play(AudioPrimary, Stage.StageMusic);
			}
		}
		else
		{
			RadiusX		   = DefaultRadiusX;
			RadiusY		   = DefaultRadiusY;
			Animation      = AnimMove;
			AllowCollision = true;
			DebugMode	   = false;
			image_alpha    = 1;
			
			Stage.UpdateObjects = true;
			Stage.TimeEnabled   = true;
			
			// Reset gravity
			if !IsUnderwater
			{
				Grv	= 0.21875;
			}
			else
			{
				// Reduce by 0x28 (0.15625) if underwater
				Grv = 0.0625
			}
		}
	}
	else if !DebugMode
	{
		return false;
	}
	
	// Update speed and position
	if Input.Left or Input.Down or Input.Right or Input.Up
	{
		DebugSpeed = min(DebugSpeed + 0.046875, 16);
	}
	else
	{
		DebugSpeed = 0;
	}
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
		DebugItem = loop_value(DebugItem + 1, 0, array_length(DebugList) - 1);
	}
	
	// Spawn current object
	else if Input.CPress
	{
		if !Input.A
		{
			var  ThisObject = image_xscale;
			var  Object     = instance_create(PosX, PosY, DebugList[DebugItem]);
			with Object
			{
				image_xscale = ThisObject;
				
				// Object should be deleted once it goes off-screen
				object_set_unload(FlagDelete);
			}
		}
		
		// If held A button, switch to the previous object in the list
		else
		{
			DebugItem = loop_value(DebugItem - 1, 0, array_length(DebugList) - 1);
		}
	}
}