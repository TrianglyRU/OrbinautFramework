function PlayerCheckBalance()
{
	if OnObject
	{
		exit;
	}
	
	if Inertia != 0
	{
		Balancing = false;
	}
	else
	{
		var DistanceLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer)[0];		
		var DistanceRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer)[0];
		var DistanceMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer)[0];
			
		if !(DistanceMiddle > 14)
		{
			exit;
		}
	
		if !DistanceLeft
		{
			Balancing = Facing;
		
		}
			
		// Else use the right tile
		else if !DistanceRight
		{	
			Balancing = -Facing;		
		}
	
		if Balancing == DirectionRight
		{
			Animation = AnimBalanceFront;
		}
		else if Balancing == DirectionLeft
		{
			Animation = AnimBalanceBack;
		}
	}
}