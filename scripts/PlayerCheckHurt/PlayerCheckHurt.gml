function PlayerCheckHurt()
{
	// Check if our hurt flag equals to object ID we got harmed by
	if Hurt > 1
	{	
		if Rings = 0
		{
			// Set flags and disable camera
			Grounded			 = false;
			Rolling				 = false;
			Jumping				 = false;
			AllowCollision		 = false;
			Screen.CameraEnabled = false;
			Stage.TimeEnabled    = false;
			
			// Perform movement
			Xsp = 0;
			Ysp = -7;	
			
			// Enter death script
			Hurt = -1;
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