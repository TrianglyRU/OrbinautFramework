function PlayerSonicDropdash()
{
	// Exit if we're not Sonic
	if CharacterID != CharSonic or !Game.DropdashEnabled or !Jumping
	{
		exit;
	}
	
	// Define our Dropdash direction by checking towards witch side we're moving and facing
	if Xsp >= 0
	{
		if Facing == DirectionLeft and Input.Left
		{
			DropdashDirection = DirectionLeft;
		}
		else
		{
			DropdashDirection = DirectionRight;
		}
	}
	else
	{
		if Facing == DirectionRight and Input.Right
		{
			DropdashDirection = DirectionLeft;
		}
		else
		{
			DropdashDirection = DirectionRight;
		}
	}
	
	// Check if A, B or C button is being on hold
	if Input.ABC
	{
		// Charge Dropdash
		if DropdashRev == -1
		{
			DropdashRev = 0;
		}
		else
		{
			if (DropdashRev < 20) DropdashRev++;
		}
	}
	
	// Reset Dropdash charge value if we've released the button
	else
	{
		DropdashRev = 0;
	}
}