function PlayerBalance()
{
	if Gsp != 0 or Animation == AnimDropStand or Animation == AnimGlideStand
	{
		return;
	}
	
	// Balance subfunctions
	#region SubFunctions
	{
		// @subfunction PlayerBalanceLeft(panicCheck)
		function PlayerBalanceLeft(panicCheck)
		{
			if Facing == FlipLeft
			{
				Animation = AnimBalance;
			}
			else if Facing == FlipRight
			{
				Animation = AnimBalanceFlip;
			}
			
			// Play additional animations for Sonic
			if global.Character == CharSonic and !SuperState
			{
				if panicCheck
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
			}
		}
		
		// @subfunction PlayerBalanceRight(panicCheck)
		function PlayerBalanceRight(panicCheck)
		{
			if Facing == FlipRight
			{
				Animation = AnimBalance;
			}
			else if Facing == FlipLeft
			{
				Animation = AnimBalanceFlip;
			}
			
			// Play additional animations for Sonic
			if global.Character == CharSonic and !SuperState
			{
				if panicCheck
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
			}
		}
	}
	#endregion
	
	// Balance on the floor
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
		
		// Balance!
		if !FindAngle1
		{	
			var FindFloor = tile_find_v(PosX + 6, PosY + RadiusY, true, false, Layer)[0];
			PlayerBalanceLeft(FindFloor >= 12);
		}
		else if !FindAngle2
		{
			var FindFloor = tile_find_v(PosX - 6, PosY + RadiusY, true, false, Layer)[0];
			PlayerBalanceRight(FindFloor >= 12);
		}
	}
	
	// Balance on the object
	else
	{
		/* In orginals, the widest balance range varies from 
		object to object (2 to 4). We'll use a range of 2 pixels */
		var Tolerance = 2;
		
		// Ignore specific objects
		if OnObject.object_index == Bridge
		{
			return;
		}
		
		// Get balance range
		var PlayerX   = OnObject.Obj_SolidX - OnObject.x + floor(PosX);
		var RightEdge = OnObject.Obj_SolidX * 2 - 1;
		
		// Balance! (if no floor found right below us)
		if  !tile_check(PosX - RadiusX, PosY + RadiusY + 1, false, Layer)
		and !tile_check(PosX + RadiusX, PosY + RadiusY + 1, false, Layer)
		{
			if PlayerX < Tolerance
			{
				PlayerBalanceLeft(PlayerX < -Tolerance);
			}
			else if PlayerX > RightEdge - Tolerance
			{
				PlayerBalanceRight(PlayerX > RightEdge + Tolerance);
			}
		}
	}
}