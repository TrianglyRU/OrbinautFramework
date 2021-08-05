function ObjSpringRampMain()
{
	// Get player position
	var PlayerPos = floor(Player.PosX - x) * sign(image_xscale);
	
	// Is springboard active?
	if JumpTimer
	{
		// Count down the timer
		JumpTimer--;
		
		// When timer reach 0 and player is on object, launch them
		if !JumpTimer and object_player_stand(id)
		{
			// Get force modifier
			var Modifier = 0;
			if PlayerPos >= 27
			{
				Modifier = 4;
			}
			else if PlayerPos >= 21
			{
				Modifier = 3;
			}
			else if PlayerPos >= 13
			{
				Modifier = 2;
			}
			else if PlayerPos >= -3  
			{
				Modifier = 1;
			}
			
			with Player
			{
				// Stop player's actions
				GlideState  = false;
				ClimbState  = false;
				FlightState = false;
				Jumping     = false;
				Rolling     = false;
				DropdashRev = -1;
			
				// Go airborne
				Grounded = false;
				OnObject = false;
				
				// Use 'spring' animation
				Animation = AnimSpring;
				
				// Launch player
				if abs(Xsp) >= 4
				{
					Xsp += Modifier * sign(Xsp);
				}
				Ysp = -4 - Modifier;
			}
			
			// Play sound
			audio_sfx_play(sfxSpring, false);
			
			// Restore default heightmap
			Obj_SolidMap = CollisionDefault;
		}
	}
	
	// If spring board is not active, check for activation
	else if object_player_stand(id) and PlayerPos >= -14 and PlayerPos <= 28
	{
		JumpTimer	 = 4;
		Obj_SolidMap = CollisionPressed;
	}
	
	// Set frame
	animation_set_frame(false, (JumpTimer > 0) + 1);
	
	// Act solid
	object_act_solid(false, true, false);
}