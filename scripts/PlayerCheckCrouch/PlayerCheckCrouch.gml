function PlayerCheckCrouch()
{	
	// Exit if LEFT or RIGHT button is held
	if (Input.Left or Input.Right) exit;
	
	// Exit if we're balancing
	if Balancing != false exit;
	
	// Check if we're holding DOWN button
	if Input.Down
	{
		// Set 'crouch' animation
		Animation = AnimCrouch;
		
		// Check if Spindash is enabled and we pressed A, B or C button
		if Game.SpindashEnabled and Input.ABCPress
		{
			// Reset animation to its first frame
			image_index = 0;
			
			// Charge Spindash
			if SpindashRev == -1
			{		
				SpindashRev = 2;
				
				// Spawn dust effect
				object_spawn(floor(PosX), floor(PosY + yRadius), SpindashDust);
				SpindashDust.image_xscale = Player.Facing;
			}
			else
			{
				 SpindashRev += 2;
			}
			
			// Limit Spindash charge to 8
			if (SpindashRev > 8) SpindashRev = 8;
			
			// Play sound
			audio_sfx_play(sfxCharge, false, true);
		}
	}
	
	// Check if Spindash is being charged
	if SpindashRev > 0 
	{
		// Set 'spindash' animation
		Animation    = AnimSpindash;
		MovementLock = -1;
		
		// Decrease Spindash charge every step
		SpindashRev -= floor(SpindashRev/0.125) / 256;
		
		// Release Spindash if we're not holding DOWN button anymore
		if !Input.Down
		{
			// Delete dust effect
			instance_destroy(SpindashDust);
			
			// Launch Sonic forwards
			Inertia		 = (8 + floor(SpindashRev) / 2) * Facing;
			MovementLock = false;
			Rolling	     = true;
			
			// Reset Spindash charge value
			SpindashRev = -1;

			// Freeze the screen for 16 frames
			if (Screen.ExtendedOffset == 0) Screen.ScrollDelay = 16;
		
			// Update collision radiuses
			yRadius = yRadiusRoll;
			xRadius	= xRadiusRoll;
			PosY   += yRadiusDefault - yRadiusRoll;
			
			// Set 'roll' animation
			Animation = AnimRoll;
		
			// Play sound
			audio_sfx_stop(sfxCharge);
			audio_sfx_play(sfxRelease, false, true);
		}
	}
}