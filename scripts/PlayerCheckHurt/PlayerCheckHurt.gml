function PlayerCheckHurt()
{
	// Check if our hurt flag equals to object ID we got harmed by
	if (Hurt > 1 and !Death) or Stage.Time = 36000
	{	
		if (!Rings and !ShieldType) or Stage.Time = 36000
		{
			// Set flags
			Grounded	   = false;
			Rolling		   = false;
			Jumping		   = false;
			Flying		   = false;
			AllowCollision = false;
			
			// Perform movement
			Xsp = 0;
			Ysp = -7;
			Grv = 0.21875;
			
			// Enter death script
			Death = true;
		}
		else
		{	
			// Lose rings
			if !ShieldType
			{
				Rings = 0;
			}
			else
			{
				ShieldType = 0;
			}
			
			// Set flags
			Grounded	 = false;
			Rolling		 = false;
			Jumping		 = false;
			Flying		 = false;

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