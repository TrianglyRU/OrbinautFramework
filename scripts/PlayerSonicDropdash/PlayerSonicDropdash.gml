function PlayerSonicDropdash()
{
	// Exit if dropdash isn't ready to be charged
	if !DropdashFlag
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
	
	// Charge Dropdash
	if DropdashRev == -1
	{
		DropdashRev = 0;
	}
	if DropdashRev < 20
	{
		DropdashRev++;
	}
}