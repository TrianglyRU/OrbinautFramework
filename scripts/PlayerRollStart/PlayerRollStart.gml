function PlayerRollStart()
{
	// Eixt if can't roll up
	if !ForcedRoll and (Input.Left or Input.Right) or SpindashRev != -1
	{
		exit;
	}

	// Check for required inertia to manually roll up
	var ManualRoll = false;
	
	if Input.Down
	{
		if Game.SKCrouch
		{
			if abs(Inertia) >= 1
			{
				ManualRoll = true;
			}
			
			// Allow player to crouch. This can actually cause
			// some issues on slopes :/
			else
			{
				Animation = AnimCrouch;
			}
		}
		else if abs(Inertia) >= 0.5
		{
			ManualRoll = true;
		}
	}
	
	// Roll up
	if ManualRoll or ForcedRoll
	{
		// Update collision radiuses
		RadiusY = SmallRadiusY;
		RadiusX	= SmallRadiusX;
		PosY   += DefaultRadiusY - SmallRadiusY;
			
		// Set flags
		Spinning  = true;
		Animation = AnimSpin;
			
		// Play sound
		audio_sfx_play(sfxRoll, false);
	}
}