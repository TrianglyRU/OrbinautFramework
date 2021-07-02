function PlayerSlopeResist()
{	
	// Set slope gravity	
	if !Game.StrongerSlopeGravity and (Angle < 45    or Angle > 315) 
	or  Game.StrongerSlopeGravity and (Angle < 33.75 or Angle > 326.25)
	{
		SlopeGravity = (Inertia != 0) * 0.125;			
	} 
	else 
	{	
		SlopeGravity = 0.125;
	}

	// Update inertia
	Inertia -= SlopeGravity * dsin(Angle);
}