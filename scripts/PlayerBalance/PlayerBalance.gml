function PlayerBalance()
{
	// Reset balancing flag
	Balancing = false;
	
	if Angle >= 46.41 and Angle <= 315
	{
		exit;
	}
	
	if OnObject or Inertia != 0
	{
		exit;
	}

	var DistanceMiddle = tile_check_collision_v(floor(PosX), floor(PosY + RadiusY), true, false, Layer)[0];		
	if  DistanceMiddle < 12
	{
		exit;
	}
	
	Balancing = true;
	
	var DistanceLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer)[0];		
	var DistanceRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer)[0];
		
	// Standing on left edge
	if !DistanceLeft
	{
		if !SuperState and !CharacterID != CharKnuckles
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
		
	// Standing on right edge
	else if !DistanceRight
	{	
		if !SuperState and !CharacterID != CharKnuckles
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