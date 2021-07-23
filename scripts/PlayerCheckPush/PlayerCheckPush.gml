function PlayerCheckPush()
{
	if Angle >= 46.41 and Angle <= 315
	{
		exit;
	}
	
	Pushing = false;

	if Input.Left or Input.Right
	{
		var StartX = floor(PosX + Xsp + 10 * sign(Facing));
		var StartY = floor(PosY + Ysp + 8 * (Angle == 360));
	
		var WallDistance = tile_check_collision_h(StartX, StartY, Facing, true, Layer)[0];
		if  !WallDistance
		{
			Pushing   = true;	
			Animation = AnimPush;
		}
	}
}