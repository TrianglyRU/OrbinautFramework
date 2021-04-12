function PlayerCheckHurt()
{
	// Check if our hurt flag equals to object ID we got harmed by
	if (Hurt > 1 and !Death) or Stage.Time == 36000
	{	
		// Set flags
		Grounded	  = false;
		Rolling		  = false;
		Jumping		  = false;
		FlyingState	  = false;
		GlidingState  = false;
		ClimbingState = false;
			
		if (Rings == 0 and !ShieldType) or Stage.Time == 36000
		{
			// Set animation
			Animation = AnimDeath;
			
			// Disable collision
			AllowCollision = false;
			
			// Perform movement
			Inertia = 0;
			Xsp		= 0;
			Ysp		= -7;
			Grv		= 0.21875;
			
			// Enter death script
			Death = true;
		}
		else
		{	
			// Set animation
			Animation = AnimHurt;
			
			// Lose rings
			if !ShieldType
			{
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
				Rings = 0;
			}
			else
			{
				ShieldType = 0;
			}

			// Knockback us
			Ysp = -4;
			Xsp =  2 * sign(PosX - Hurt.x);
		
			// Lower our gravity
			Grv = 0.1875;
		
			// Enter hurt script
			Hurt = true;
		}
	}
}