function PlayerCheckCrouch()
{	
	// Exit if we're moving
	if !Game.LooseCrouch and Inertia != 0
	{
		exit;
	}
	
	// Exit if we're balancing
	if !Game.BalancingCrouch and (Animation == AnimBalanceBack or Animation == AnimBalanceFront)
	{
		exit;
	}
	
	// Check if Spindash is being charged
	if SpindashRev >= 0 
	{
		// Use 'spindash' animation
		Animation = AnimSpindash;

		// Decrease spindash force every step
		SpindashRev -= floor(SpindashRev / 0.125) / 256;
		
		// Check if we press any of action buttons
		if Input.ABCPress
		{
			// Increase spindash force
			SpindashRev = min(SpindashRev + 2, 8);
			
			// Reset to first frame
			animation_set_frame(sprite_index, 1);

			// Play sound
			audio_sfx_play(sfxCharge, false);
		}
		
		// Release Spindash if we're not holding DOWN button anymore
		if !Input.Down
		{
			// Define minimum speed
			var MinimumSpd = !SuperState ? 8 : 11;

			// Launch Sonic forwards
			Inertia		 = (MinimumSpd + round(SpindashRev) / 2) * Facing;
			MovementLock = false;
			Rolling	     = true;
			
			// Freeze the screen
			if Screen.ExtendedOffset == 0 
			{
				Screen.ScrollDelay = 16;
			}
			
			// Reset Spindash charge value
			SpindashRev = -1;

			// Update collision radiuses
			yRadius = yRadiusRoll;
			xRadius	= xRadiusRoll;
			PosY   += yRadiusDefault - yRadiusRoll;
			
			// Set 'roll' animation
			Animation = AnimRoll;
		
			// Play sound
			audio_sfx_stop(sfxCharge);
			audio_sfx_play(sfxRelease, false);
		}
	}
	
	// Check if we're holding DOWN button
	else if Input.Down and !Input.Left and !Input.Right
	{
		// Set 'crouch' animation
		Animation = AnimCrouch;
				
		// Check if Spindash is enabled and we pressed A, B or C button
		if Game.SpindashEnabled and Input.ABCPress
		{
			// Create dust effect
			instance_create(floor(PosX), floor(PosY + yRadius), SpindashDust);
			
			// Set 'spindash' animation
			Animation = AnimSpindash;
			
			// Start Spindash
			SpindashRev  = 2;
			MovementLock = -1;
			audio_sfx_play(sfxCharge, false);
		}
	}
	
	// Return rolling flag
	return Rolling;
}