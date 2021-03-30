function PlayerCheckDropdash()
{
	// Check if we're Sonic
	if CharacterID != CharSonic exit;
	
	// Check if dropdash is enabled
	if Game.DropdashEnabled == false exit;
	
	// Check if we're jumping
	if Jumping == false exit;
	
	// Check if we're moving forwards or backwards
	if Xsp >= 0
	{
		if Facing == FacingLeft and Input.Left
		{
			DropdashDirection = -1;
		}
		else
		{
			DropdashDirection = 1;
		}
	}
	else
	{
		if Facing == FacingRight and Input.Right
		{
			DropdashDirection = -1;
		}
		else
		{
			DropdashDirection = 1;
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