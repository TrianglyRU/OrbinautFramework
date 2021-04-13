function PlayerCheckHurt()
{
	// Check if our hurt flag equals to object ID we got harmed by (we do Hurt = object.id)
	if (Hurt > 1 and !Death) or Stage.Time == 36000
	{	
		// Set flags
		Grounded	  = false;
		OnObject	  = false;
		Rolling		  = false;
		Jumping		  = false;
		FlyingState	  = false;
		GlidingState  = false;
		ClimbingState = false;
		
		// Check if we do not have rings when not under barrier, or time is out
		if (Rings == 0 and !ShieldType) or Stage.Time == 36000
		{
			// Set animation
			Animation = AnimDeath;
			
			// Disable collision and camera
			Screen.CameraEnabled = false;
			AllowCollision       = false;
			
			// Perform movement
			Inertia = 0;
			Xsp		= 0;
			Ysp		= -7;
			Grv		= 0.21875;
			
			// Enter death script
			Death = true;
		}
		
		// If we have rings
		else
		{	
			// Set animation
			Animation = AnimHurt;
			
			// Lose rings if we do not have active barrier
			if !ShieldType
			{
				// Spread them
				var Dir = -1
				var Ang = 168.75
				var Spd = 4
				for (var i = 0; i < min(Rings, 32); i++) 
				{
					var Created = instance_create_depth(0, 0, 0, Ring);
					if  i == 16 
					{ 
						Ang = 168.75; 
						Spd = 2;
					}
					Created.Physical = true;
					Created.PickupTimeout = 64;
					Created.PosX	 = floor(PosX);
					Created.PosY	 = floor(PosY);
					Created.Xsp	     = Spd * dsin(Ang) * Dir;
					Created.Ysp		 = Spd * dcos(Ang)
					if Dir 
					{ 
						Ang -= 22.5;
					}
					Dir *= -1
				}
				
				// Update ring counter
				Rings = 0;
			}
			
			// Else just lose barrier
			else
			{
				ShieldType = 0;
			}

			// Perform movement
			Ysp = -4;
			Xsp =  2 * sign(PosX - Hurt.x);
			Grv = 0.1875;
		
			// Enter hurt script
			Hurt = true;
		}
	}
}