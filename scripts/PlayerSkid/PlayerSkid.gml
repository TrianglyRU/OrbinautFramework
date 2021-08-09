function PlayerSkid()
{
	// Start skidding
	if Skidding == false
	{
		if MovementLock or NoControls
		{
			exit;
		}	
		if Angle >= 46.41 and Angle <= 315
		{
			exit;
		}
		if abs(Inertia) < 4
		{
			exit;
		}
		if Inertia and Input.Left or !Inertia and Input.Right
		{
			Skidding = sign(Inertia);
			audio_sfx_play(sfxSkid, false);
			
			// Create dust effect
			instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
		}
	}
	if Skidding != false
	{
		// Set 'skid' animation
		Animation = AnimSkid;

		if !Inertia and Input.Left or Inertia and Input.Right or Inertia == 0
		{
			Skidding = false;
		}
	}
}