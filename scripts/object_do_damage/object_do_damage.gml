/// @function object_do_damage(instantKill)
function object_do_damage(instantKill)
{
	// Exit if player is invincible
	if (Player.isInvincible or Player.Hurt) exit;
	
	// Set flags
	Player.Grounded	     = false;
	Player.OnObject	     = false;
	Player.Rolling		 = false;
	Player.Jumping		 = false;
	Player.FlyingState	 = false;
	Player.GlidingState  = false;
	Player.ClimbingState = false;
	
	if !Player.Rings and !Player.ShieldType or instantKill
	{
		// Set animation
		Player.Animation = AnimDeath;
			
		// Disable collision and camera
		Screen.CameraEnabled  = false;
		Player.AllowCollision = false;
		
		// Draw player above everything
		Player.DrawOrder -= 5;
			
		// Perform movement
		Player.Inertia = 0;
		Player.Xsp	   = 0;
		Player.Ysp	   = -7;
		Player.Grv	   = 0.21875;
			
		// Enter death script
		Player.Death = true;
		
		// Play sound
		var deathSound = object_index == TripleSpikesV ? sfxDeathSpike : sfxDeath;
		audio_sfx_play(deathSound, false, true);
	}
		
	// If we have rings
	else
	{	
		// Set animation
		Player.Animation = AnimHurt;
			
		// Lose rings if we do not have active barrier
		if !Player.ShieldType
		{
			// Spread them
			var Dir = -1
			var Ang = 168.75
			var Spd = 4
			for (var i = 0; i < min(Player.Rings, 32); i++) 
			{
				var Created = instance_create_depth(floor(Player.PosX), floor(Player.PosY), 0, Ring);
				if  i == 16 
				{ 
					Ang = 168.75; 
					Spd = 2;
				}
				with Created
				{
					object_set_solidbox(8, 8);
				}		
				Created.Physical      = true;
				Created.PickupTimeout = 64;
				Created.Xsp			  = Spd * dsin(Ang) * Dir;
				Created.Ysp			  = Spd * dcos(Ang);
				
				if Dir 
				{ 
					Ang -= 22.5;
				}
				Dir *= -1
			}
				
			// Update ring counter
			Player.Rings = 0;
			
			// Play sound
			audio_sfx_play(sfxRingLoss, false, true);
		}
			
		// Else just lose barrier
		else
		{
			Player.ShieldType = 0;
		}

		// Perform movement
		Player.Ysp = -4;
		Player.Xsp =  2 * sign(Player.PosX - id.x);
		Player.Grv = 0.1875;
		
		// Enter hurt script
		Player.Hurt = true;
	}
}