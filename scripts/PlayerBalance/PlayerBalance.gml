function PlayerBalance()
{
	if Gsp != 0 or Animation == AnimDropStand or Animation == AnimGlideStand
	{
		return;
	}
	
	// Balance on floor
	if !OnObject
	{
		if global.SKCrouch and Input.Down
		{
			return;
		}
		if Angle >= 46.41 and Angle <= 313.59
		{
			return;
		}
		
		// Check for floor
		var FindFloor = tile_find_v(PosX, PosY + RadiusY, true, false, Layer)[0];	
		if  FindFloor < 12
		{
			return;
		}
		
		// Get floor angles and continue if only one exists
		var FindAngle1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer)[1];
		var FindAngle2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer)[1];
		
		if !(FindAngle1 and !FindAngle2 or !FindAngle1 and FindAngle2)
		{
			return;
		}
	
		// Balance on the left side
		if !FindAngle1
		{	
			if !SuperState and global.Character == CharSonic
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
		
		// Balance on the right side
		else if !FindAngle2
		{
			if !SuperState and global.Character == CharSonic
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
	
	// Balance on the object
	else
	{
		/* In orginals, the widest balance range varies from 
		object to object (2 to 4). We'll use a range of 2 pixels */
		
		// Ignore specific objects
		if OnObject.object_index == Bridge
		{
			return;
		}
		
		// Get balance range
		var PlayerX   = OnObject.Obj_SolidX - OnObject.x + floor(PosX);
		var RightEdge = OnObject.Obj_SolidX * 2 - 1;
		
		// Balance on the left side
		if PlayerX < 2
		{
			if !SuperState and global.Character == CharSonic
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
		
		// Balance on the right side
		else if PlayerX > RightEdge - 2
		{
			if !SuperState and global.Character == CharSonic
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