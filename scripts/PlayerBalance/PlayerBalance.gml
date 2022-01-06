function PlayerBalance()
{
	// Exit moving or getting up
	if Inertia != 0 or Animation == AnimDropStand or Animation == AnimGlideStand
	{
		exit;
	}
	
	// Balance on floor
	if !OnObject
	{
		// Exit if holding down when S&K crouching is enabled
		if Game.SKCrouch and Input.Down
		{
			exit;
		}
		
		// Exit if angle is too steep
		if Angle >= 46.41 and Angle <= 313.59
		{
			exit;
		}
		
		// Check for floor
		var FindFloor = tile_find_v(PosX, PosY + RadiusY, true, false, Layer)[0];	
		if  FindFloor < 12
		{
			exit;
		}
		
		// Get floor angles
		var FindAngle1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer)[1];
		var FindAngle2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer)[1];
		
		// Continue if only one angle exists
		if !(FindAngle1 or FindAngle2)
		{
			exit;
		}
	
		// Standing on the left edge
		if !FindAngle1
		{	
			if !SuperState and Game.Character == CharSonic
			{
				// Use "panic balance" animation
				var FindFloor  = tile_find_v(PosX + 6, PosY + RadiusY, true, false, Layer)[0];
				if  FindFloor >= 12
				{
					if Facing == FlipRight
					{
						Animation = AnimBalanceTurn;
						Facing	  = FlipLeft;
					}
					else
					{
						Animation = AnimBalancePanic;
					}
				}
				
				// Use two-sided balance animation
				else
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
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipLeft;
				Animation = AnimBalance;
			}
		}
		
		// Standing on the right edge
		else if !FindAngle2
		{
			if !SuperState and Game.Character == CharSonic
			{
				// Use "panic balance" animation
				var FindFloor  = tile_find_v(PosX - 6, PosY + RadiusY, true, false, Layer)[0];
				if  FindFloor >= 12
				{
					if Facing == FlipLeft
					{
						Animation = AnimBalanceTurn;
						Facing	  = FlipRight;
					}
					else
					{
						Animation = AnimBalancePanic;
					}
				}
				
				// Use two-sided balance animation
				else
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
		/* In orginals, the widest balance range varies from object to object (2 to 4). We'll
		use a range of 2 pixels */
		
		// Ignore specific objects
		if OnObject.object_index == Bridge
		{
			exit;
		}
		
		// Get balance range
		var PlayerX   = OnObject.Obj_SolidX - OnObject.x + floor(PosX);
		var RightEdge = OnObject.Obj_SolidX * 2 - 1;
		
		// Standing on the left edge
		if PlayerX < 2
		{
			if !SuperState and Game.Character == CharSonic
			{
				// Use "panic balance" animation
				if PlayerX < -2
				{
					if Facing == FlipRight
					{
						Animation = AnimBalanceTurn;
						Facing	  = FlipLeft;
					}
					else
					{
						Animation = AnimBalancePanic;
					}
				}
				
				// Use two-sided balance animation
				else
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
			}
			
			// Use one-sided balance animation
			else
			{
				Facing    = FlipLeft;
				Animation = AnimBalance;
			}
		}
		
		// Standing on the right edge
		else if PlayerX > RightEdge - 2
		{
			if !SuperState and Game.Character == CharSonic
			{
				// Use "panic balance" animation
				if PlayerX > RightEdge + 2
				{
					if Facing == FlipLeft
					{
						Animation = AnimBalanceTurn;
						Facing	  = FlipRight;
					}
					else
					{
						Animation = AnimBalancePanic;
					}
				}
				
				// Use two-sided balance animation
				else
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