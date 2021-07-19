function PlayerCheckPush()
{
	if Angle >= 46.41 and Angle <= 315
	{
		exit;
	}

	if Pushing == false
	{
		var StartX = floor(PosX + Xsp + 10 * sign(Facing));
		var StartY = floor(PosY + Ysp + 8 * (Angle == 360));
	
		var WallDistance = tile_check_collision_h(StartX, StartY, Facing, true, Layer)[0];
		if  WallDistance < 0
		{
			Pushing = Facing;	
		}
	}		

	// Don't do 'else' so we perform this at the very same frame
	if Pushing != false
	{
		if sign(Pushing) != sign(Inertia)
		{
			Pushing = false;
		}
		else
		{
			Animation = AnimPush;
		}
	}
}