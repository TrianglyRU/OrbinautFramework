function PlayerCheckHurt()
{
	// Check if our hurt flag equals to object ID we got harmed by
	if (Hurt > 1 and !Death) or Stage.Time = 36000
	{	
		if Rings = 0 or Stage.Time = 36000
		{
			// Set flags and disable camera
			Grounded	   = false;
			Rolling		   = false;
			Jumping		   = false;
			AllowCollision = false;
			
			// Perform movement
			Xsp = 0;
			Ysp = -7;	
			
			// Enter death script
			Death = true;
		}
		else
		{	
			// Lose rings
			Rings = 0;
			
			// Set flags
			Grounded	 = false;
			Rolling		 = false;
			Jumping		 = false;

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