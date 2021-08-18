function PlayerSonicDropdash()
{
	// Exit if we can't perform dropdash
	if Game.Character != CharSonic or !Game.DropdashEnabled or !Player.Jumping
	{
		exit;
	}
	
	// Define dropdash direction
	if Player.Xsp >= 0
	{
		if Player.Facing == FlipLeft and Input.Left
		{
			Player.DropdashDirection = FlipLeft;
		}
		else
		{
			Player.DropdashDirection = FlipRight;
		}
	}
	else
	{
		if Player.Facing == FlipRight and Input.Right
		{
			Player.DropdashDirection = FlipLeft;
		}
		else
		{
			Player.DropdashDirection = FlipRight;
		}
	}
	
	// Charge Dropdash
	if Input.ABC
	{
		if Player.DropdashRev == -1
		{
			Player.DropdashRev = 0;
		}
		else if Player.DropdashRev < 20
		{
			Player.DropdashRev++;
		}
	}
	else
	{
		Player.DropdashRev = 0;
	}
}