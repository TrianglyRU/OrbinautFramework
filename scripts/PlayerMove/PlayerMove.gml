function PlayerMove()
{	
	// Exit if spindashing
	if SpindashRev >= 0 exit;

	// Accelerate and decelerate
	if !MovementLock
	{
		if Input.Left
		{	
			// If moving right and left key is pressed, decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if (Inertia <= 0) Inertia = -0.5;	
			} 
			
			// If moving left and left key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia > -TopAcc) or Game.GroundSpeedcap
				{
					Inertia -= Acc;					
					if (Inertia <= -TopAcc) Inertia = -TopAcc;		
				} 
				Facing = FacingLeft;
			}
		}
		if Input.Right 
		{				
			// If moving left and right key is pressed, decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if (Inertia >= 0) Inertia = 0.5;
			} 
			
			// If moving right and right key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia < TopAcc) or Game.GroundSpeedcap
				{
					Inertia += Acc;
					if (Inertia >= TopAcc) Inertia = TopAcc;	
				} 
				Facing = FacingRight;
			}
		}
	}
	
	// Apply friction
	if !Input.Left and !Input.Right and Inertia != 0 or MovementLock != 0
	{
		if Inertia > 0
		{
			Inertia -= Acc;
			if (Inertia < 0) Inertia = 0;
		}
		else
		{
			Inertia += Acc;
			if (Inertia >= 0) Inertia = 0;
		}
	}
	
	// Set animation
	if Inertia = 0
	{
		if Input.Down
		{
			Animation = AnimCrouch;
		}
		else if Input.Up
		{
			Animation = AnimLookup;
		}
		else
		{
			Animation = AnimIdle;
		}
	} 
	else
	{
		Animation = abs(Inertia) < TopAcc? AnimWalk : AnimRun;
	}
	
	// Get movement angle
	/*switch round(Angle/90) % 4
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
	*/
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
}