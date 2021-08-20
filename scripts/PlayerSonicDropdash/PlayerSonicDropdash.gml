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
		if Facing == FlipLeft and Input.Left
		{
			DropdashDirection = FlipLeft;
		}
		else
		{
			DropdashDirection = FlipRight;
		}
	}
	else
	{
		if Facing == FlipRight and Input.Right
		{
			DropdashDirection = FlipLeft;
		}
		else
		{
			DropdashDirection = FlipRight;
		}
	}
	
	// Charge Dropdash
	if DropdashRev == -1
	{
		DropdashRev = 0;
	}
	else if DropdashRev < 20
	{
		DropdashRev++;
	}
}