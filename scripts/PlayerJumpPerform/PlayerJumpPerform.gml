function PlayerJumpPerform()
{	
	// Exit the code if found the low ceiling
	if collision_meeting(floor(PosX - 9), floor(PosY - 25), true)
	or collision_meeting(floor(PosX + 9), floor(PosY - 25), true) exit;
	
	// Exit the code if spindashing
	if SpindashRev >= 0 exit;

	// Jump
	if Input.ABCPress
	{
		Xsp          -= Jump * dsin(Angle);
		Ysp	         -= Jump * dcos(Angle);	
		Jumping		  = true;	
		Grounded      = false;
		OnObject	  = false;
		if (Game.RolljumpControl) Rolling  = false;
		
		// Update radiuses
		yRadius = yRadiusRoll;
		xRadius	= 7;
		PosY   += 5;
	}
	
}