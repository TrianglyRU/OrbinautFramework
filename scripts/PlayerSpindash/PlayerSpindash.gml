function PlayerSpindash()
{
	// Exit if spindash is disableds
	if !Game.SpindashEnabled
	{
		exit;
	}
	
	// Start spindash
	if SpindashRev == -1
	{
		if Animation == AnimCrouch and Input.ABCPress
		{
			SpindashRev = 0;
			Xsp			= 0;
			
			// Play sound
			audio_sfx_play(sfxCharge, false);
			
			// Create dust effect
			instance_create(PosX, PosY + RadiusY, SpindashDust);
		}
	}
	
	// Charge spindash
	else if Input.Down
	{
		// Reduce force
		SpindashRev -= floor(SpindashRev / 0.125) / 256;
		
		// Increase force
		if Input.ABCPress
		{
			SpindashRev = min(SpindashRev + 2, 8);
			audio_sfx_play(sfxCharge, false);
			
			// Reset animation
			animation_reset(0);
		}
	}
	
	// Release spindash
	else
	{
		// Calculate minimum release speed
		var MinimumSpd = !SuperState ? 8 : 11;

		// Launch player
		Inertia	    = (MinimumSpd + round(SpindashRev) / 2) * Facing;
		Spinning    = true;
		SpindashRev = -1;
		Animation   = AnimSpin;
			
		// Freeze the screen for 16 frames
		if !Game.CDCamera
		{
			Camera.ScrollDelay = 16;
		}
			
		// Update collision radiuses
		RadiusX	= SmallRadiusX;
		RadiusY	= SmallRadiusY;
		PosY   += DefaultRadiusY - SmallRadiusY;
		
		// Play sound
		audio_sfx_stop(sfxCharge);
		audio_sfx_play(sfxRelease, false);
	}
	
	// Apply spindash animation
	if SpindashRev >= 0
	{
		Animation = AnimSpindash;
	}
	
	// Return spindash result
	return Spinning;
}