function PlayerMoveRoll()
{
	// Perform only if directional input is allowed
	if !MovementLock
	{
		// If pressing left
		if Input.Left 
		{
			if Inertia > 0 
			{
				Inertia -= RollDec;
				if Inertia <= 0 
				{
					Inertia = -0.5;
					Facing  = FacingLeft;
				}
			}
		}
	
		// If pressing right
		if Input.Right 
		{
			if Inertia < 0 
			{
				Inertia += RollDec;
				if Inertia >= 0 
				{
					Inertia = 0.5;
					Facing  = FacingRight;
				}
			}
		}
	}

	// Apply friction
	if Inertia > 0
	{
		Inertia -= Acc / 2;
		if (Inertia < 0) Inertia = 0;
	}
	else if Inertia < 0
	{
		Inertia += Acc / 2;
		if (Inertia >= 0) Inertia = 0;
	}
	
	// Get movement angle
	switch round(Angle/90) % 4
	{
		case RangeFloor:
		{	
			var xLeft  = floor(PosX - xRadius);
			var yLeft  = floor(PosY + yRadius);
			var xRight = floor(PosX + xRadius);
			var yRight = floor(PosY + yRadius);
			
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
			var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
		}
		break;
		case RangeRWall:
		{	
			var xLeft  = floor(PosX + yRadius);
			var yLeft  = floor(PosY + xRadius);
			var xRight = floor(PosX + yRadius);
			var yRight = floor(PosY - xRadius);
			
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
		}
		break;
		case RangeRoof:
		{	
			var xLeft  = floor(PosX + xRadius);
			var yLeft  = floor(PosY - yRadius);
			var xRight = floor(PosX - xRadius);
			var yRight = floor(PosY - yRadius);

			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);
		}
		break;
		case RangeLWall:
		{	
			var xLeft  = floor(PosX - yRadius);
			var yLeft  = floor(PosY - xRadius);
			var xRight = floor(PosX - yRadius);
			var yRight = floor(PosY + xRadius);
			
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
		}
		break;
	}
	var Ang = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
	
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Ang);
	Ysp = Inertia * -dsin(Ang);
	
	// Limit rolling speed. Original engine limits xsp instead of inertia, resulting
	// desync on high speeds
	if Game.OriginalRollLimit
	{
		if (Xsp > 16)  Xsp = 16;
		if (Xsp < -16) Xsp = -16;
	}
	
	// If our inertia is 0 or we pressed UP, unroll
	if Inertia = 0 or (Game.AllowUnroll and Input.UpPress and abs(Inertia) > 2.5)
	{
		// Reset radiuses (we do not adjust position, tile collision will do this automatically)
		yRadius = yRadiusDefault;
		xRadius = xRadiusDefault;
		
		// Unroll
		Rolling = false;
		
		// Set animation
		Animation = AnimIdle;
	}
}