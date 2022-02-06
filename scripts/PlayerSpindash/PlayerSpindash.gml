function PlayerSpindash()
{
	if !Game.SpindashEnabled
	{
		return;
	}
	
	// Start spindash
	if SpindashRev == -1
	{
		if Animation == AnimCrouch and Input.ABCPress
		{
			SpindashRev = 0;
			Xsp			= 0;
			
			instance_create(PosX, PosY + RadiusY, SpindashDust);
			audio_sfx_play(sfxCharge, false);
		}
	}
	
	// Charge spindash
	else if Input.Down
	{
		if Input.ABCPress
		{
			SpindashRev = min(SpindashRev + 2, 8);
			
			animation_reset(0);
			audio_sfx_play(sfxCharge, false);
		}
		else
		{
			SpindashRev -= floor(SpindashRev / 0.125) / 256;
		}
		
		// Spawn dust object once again if it was deleted
		if Player.Grounded and !instance_exists(SpindashDust)
		{
			instance_create(PosX, PosY + RadiusY, SpindashDust);
		}
	}
	
	// Release spindash
	else
	{
		if !Game.CDCamera
		{
			Camera.ScrollDelay = 16;
		}
		
		Inertia	    = ((SuperState ? 11 : 8) + round(SpindashRev) / 2) * Facing;
		Spinning    = true;
		SpindashRev = -1;
		Animation   = AnimSpin;
			
		RadiusX	= SmallRadiusX;
		RadiusY	= SmallRadiusY;
		PosY   += DefaultRadiusY - SmallRadiusY;
		
		audio_sfx_stop(sfxCharge);
		audio_sfx_play(sfxRelease, false);
		
		// Convert inertia to speed. Originals don't do this, so you could jump straight upwards there!
		if Game.FixDashRelease
		{
			Xsp = Inertia *  dcos(Angle);
			Ysp = Inertia * -dsin(Angle);
		}
	}
	
	// Apply spindash animation
	if SpindashRev >= 0
	{
		Animation = AnimSpindash;
	}
	
	return Spinning;
}