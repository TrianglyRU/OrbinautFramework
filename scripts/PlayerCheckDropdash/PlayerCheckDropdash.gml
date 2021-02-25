function PlayerCheckDropdash()
{
	// Check if we're Sonic
	if CharacterID != CharSonic exit;
	
	// Check if we're moving forwards or backwards
	if Xsp >= 0
	{
		if Facing = FacingLeft and Input.Left 
		{
			var MoveDir = -1;
		}
		else
		{
			var MoveDir = 1;
		}
	}
	else
	{
		if Facing = FacingRight and Input.Right
		{
			var MoveDir = -1;
		}
		else
		{
			var MoveDir = 1;
		}
	}
	
	// Charge dropdash
	if !Grounded
	{
		if Input.ABC
		{
			if DropdashRev = -2
			{
				DropdashRev = 1;
			}
			else
			{
				if (DropdashRev < 20) DropdashRev++;
			}
		}
		else
		{
			DropdashRev = 0;
		}
	}
	
	// Release on landing
	else if DropdashRev = 20
	{	
		// Go to rolling state
		Rolling = true;
		
		// Set dropspeed
		if MoveDir = 1
		{
			var Dropspeed = Inertia / 4 + 8 * Facing;
		}
		else
		{
			if Angle = 0
			{
				var Dropspeed = 8 * Facing;
			}
			else
			{
				var Dropspeed = Inertia / 2 + 8 * Facing;
			}
		}
		if (Dropspeed >  12) Dropspeed =  12;
		if (Dropspeed < -12) Dropspeed = -12;
		
		// Apply dropspeed to inertia and set camera lag
		Inertia			   = Dropspeed;
		Screen.ScrollDelay = 16;
	}
}