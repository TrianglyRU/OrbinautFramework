function PlayerSonicDropdash()
{
	if DropdashFlag != DashActive
	{
		return;
	}
	
	// Define our dropdash direction by checking towards witch side we're moving and facing
	if Xsp >= 0
	{
		if Facing == FlipLeft and Input.Left
		{
			DropdashSide = FlipLeft;
		}
		else
		{
			DropdashSide = FlipRight;
		}
	}
	else
	{
		if Facing == FlipRight and Input.Right
		{
			DropdashSide = FlipLeft;
		}
		else
		{
			DropdashSide = FlipRight;
		}
	}
	
	// Charge Dropdash
	if DropdashRev == -1
	{
		DropdashRev = 0;
	}
	else if DropdashRev < 20
	{
		// Set animaion once fully charged
		if (++DropdashRev) == 20
		{
			Animation = AnimDropdash;
			
			// Play sound
			audio_sfx_play(sfxDropDash, false);
		}
	}
}