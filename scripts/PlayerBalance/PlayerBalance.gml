function PlayerBalance()
{
	// Exit if holding down when S&K crouching is enabled, or moving
	if Game.SKCrouch and Input.Down or Inertia != 0
	{
		exit;
	}
	
	// Balance on floor
	if !OnObject
	{
		// Exit if angle is too steep
		if Angle >= 46.41 and Angle <= 313.59
		{
			exit;
		}
		
		// Check for floor
		var FloorDistance = tile_check_collision_v(floor(PosX), floor(PosY + RadiusY), true, false, Layer)[0];	
		if  FloorDistance < 12
		{
			exit;
		}
		
		// Get floor angles
		var LeftAngle  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer)[1];
		var RightAngle = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer)[1];
		
		// Continue if only one angle exists
		if !(LeftAngle or RightAngle)
		{
			exit;
		}
	
		// Standing on the left edge
		if !LeftAngle
		{	
			// Use two-sided balance animation
			if !SuperState and Game.Character == CharSonic
			{
				if Facing == FlipLeft
				{
					Animation = AnimBalance;
				}
				else if Facing == FlipRight
				{
					Animation = AnimBalanceFlip;
				}
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipLeft;
				Animation = AnimBalance;
			}
		}
		
		// Standing on the right edge
		else if !RightAngle
		{
			// Use two-sided balance animation
			if !SuperState and Game.Character == CharSonic
			{
				if Facing == FlipRight
				{
					Animation = AnimBalance;
				}
				else if Facing == FlipLeft
				{
					Animation = AnimBalanceFlip;
				}
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipRight;
				Animation = AnimBalance;
			}
		}
	}
	
	// Balance on object
	else
	{
		// Ignore specific objects
		if OnObject.object_index == Bridge
		{
			exit;
		}
		
		// Get balance range
		var ObjectWidth  = OnObject.Obj_SolidX * 2 - 4;
		var EdgeDistance = OnObject.Obj_SolidX - OnObject.x + floor(PosX);
		
		// Standing on the left edge
		if EdgeDistance < 2
		{
			// Use two-sided balance animation
			if !SuperState and Game.Character == CharSonic
			{
				if Facing == FlipLeft
				{
					Animation = AnimBalance;
				}
				else if Facing == FlipRight
				{
					Animation = AnimBalanceFlip;
				}
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipLeft;
				Animation = AnimBalance;
			}
		}
		
		// Standing on the right edge
		else if EdgeDistance >= ObjectWidth
		{
			// Use two-sided balance animation
			if !SuperState and Game.Character == CharSonic
			{
				if Facing == FlipRight
				{
					Animation = AnimBalance;
				}
				else if Facing == FlipLeft
				{
					Animation = AnimBalanceFlip;
				}
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipRight;
				Animation = AnimBalance;
			}
		}
	}
}