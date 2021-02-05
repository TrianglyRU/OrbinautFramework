function PlayerCheckHurt()
{
	// Check if our hurt state equals to object ID we got harmed by
	if Hurt > 1
	{			
		// Set flags
		Grounded	 = false;
		Rolling		 = false;
		Jumping		 = false;

		// Knockback us
		Ysp = -4;
		Xsp =  2 * sign(PosX - Hurt.x);
		
		// Lower our gravity
		Grv = 0.1875;
		
		// End hurt script
		Hurt = true;
	}
}