function PlayerBalance()
{
	// Reset balancing flag
	Balancing = false;
	
	if Angle >= 46.41 and Angle <= 313.59
	{
		exit;
	}
	
	if OnObject or Inertia != 0
	{
		exit;
	}

	var Distance = tile_check_collision_v(floor(PosX), floor(PosY + RadiusY), true, false, Layer)[0];	
	if  Distance < 12
	{
		exit;
	}
	
	var LeftAngle  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer)[1];
	var RightAngle = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer)[1];
	
	if !(LeftAngle or RightAngle)
	{
		exit;
	}
	
	Balancing = true;
		
	// Standing on right edge
	if !RightAngle
	{
		if !SuperState or CharacterID == CharSonic
		{
			if Facing == DirectionRight
			{
				Animation = AnimBalanceFront;
			}
			else if Facing == DirectionLeft
			{
				Animation = AnimBalanceBack;
			}
		}
		else
		{
			Facing    = DirectionRight;
			Animation = AnimBalanceFront;
		}
	}
		
	// Standing on left edge
	else if !LeftAngle
	{	
		if !SuperState or CharacterID == CharSonic
		{
			if Facing == DirectionLeft
			{
				Animation = AnimBalanceFront;
			}
			else if Facing == DirectionRight
			{
				Animation = AnimBalanceBack;
			}
		}
		else
		{
			Facing    = DirectionLeft;
			Animation = AnimBalanceFront;
		}
	}
}