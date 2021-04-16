function PlayerCheckDropdash()
{
	// Exit if we're not Sonic
	if CharacterID != CharSonic exit;
	
	// Exit if Dropdash is disabled
	if !Game.DropdashEnabled exit;
	
	// Exit if we're not jumping
	if !Jumping exit;
	
	// Define our Dropdash direction by checking towards witch side we're moving and facing
	if Xsp >= 0
	{
		if Facing == DirLeft and Input.Left
		{
			DropdashDirection = DirLeft;
		}
		else
		{
			DropdashDirection = DirRight;
		}
	}
	else
	{
		if Facing == DirRight and Input.Right
		{
			DropdashDirection = DirLeft;
		}
		else
		{
			DropdashDirection = DirRight;
		}
	}
	
	// Check if A, B or C button is being on hold
	if Input.ABC
	{
		// Charge Dropdash
		if DropdashRev == -1
		{
			DropdashRev = 1;
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