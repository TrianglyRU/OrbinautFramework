function PlayerCheckDropdash()
{
	// Check if we're Sonic
	if CharacterID != CharSonic exit;
	
	// Check if dropdash is enabled
	if !Game.DropdashEnabled exit;
	
	// Check if we're jumping
	if !Jumping exit;
	
	// Check if we're moving forwards or backwards
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
	
	// Charge dropdash
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
	
	// Reset it if we released button
	else
	{
		DropdashRev = 0;
	}
}