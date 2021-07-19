function PlayerCheckSkid()
{
	// Start skidding
	if Skidding == false
	{
		if MovementLock
		{
			exit;
		}	
		if Angle >= 46.41 and Angle <= 313.59
		{
			exit;
		}
		if abs(Inertia) < 4
		{
			exit;
		}
		
		if Inertia > 0 and Input.Left or Inertia < 0 and Input.Right
		{
			Skidding = sign(Inertia);
			
			audio_sfx_play(sfxSkid, false);
		}
	}
	
	// Don't do 'else' so we perform this at the very same frame
	if Skidding != false
	{
		Animation = AnimSkid;
		
		if SkiddingTimer mod 4 == 0
		{
			instance_create(floor(PosX), floor(PosY + yRadius), DustPuff);
		}
		SkiddingTimer++;
		
		if Inertia < 0 and Input.LeftPress or Inertia > 0 and Input.RightPress or sign(Inertia) != sign(Skidding)
		{
			SkiddingTimer = 0;
			Skidding	  = false;
		}
	}
}