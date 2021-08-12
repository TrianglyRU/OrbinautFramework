function PlayerRollStart()
{
	// You are not able to roll if side direction button is pressed
	if !ForcedRoll and (Input.Left or Input.Right)
	{
		exit;
	}

	// Start rolling if we're moving fast enough and are not gliding
	if Input.Down
	{
		if !Game.LooseCrouch and abs(Inertia) >= 0.5 
		or  Game.LooseCrouch and abs(Inertia) >= 1
		{
			// Update radiuses
			RadiusY = SmallRadiusY;
			RadiusX	= SmallRadiusX;
			PosY   += DefaultRadiusY - SmallRadiusY;
			
			// Set rolling flag
			Spinning = true;
			
			// Set animation
			Animation = AnimRoll;
			
			// Play sound
			audio_sfx_play(sfxRoll, false);
		}
	}	
	
	if ForcedRoll and !Spinning
	{
		// Update radiuses
		RadiusY = SmallRadiusY;
		RadiusX	= SmallRadiusX;
		PosY   += DefaultRadiusY - SmallRadiusY;
			
		// Set rolling flag
		Spinning = true;
			
		// Set animation
		Animation = AnimRoll;
			
		// Play sound
		audio_sfx_play(sfxRoll, false);
	}
}