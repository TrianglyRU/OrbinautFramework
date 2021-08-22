function PlayerRollStart()
{
	// Eixt if can't roll up
	if !ForcedRoll and (Input.Left or Input.Right) or SpindashRev != -1
	{
		exit;
	}

	// Check for inertia required to manually roll up
	if Game.SKRollDeceleration
	{
		var RollCheck = abs(Inertia) >= 1;
	}
	else
	{
		var RollCheck = abs(Inertia) >= 0.5;
	}
	
	// Roll up
	if Input.Down and RollCheck or ForcedRoll and !Spinning
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