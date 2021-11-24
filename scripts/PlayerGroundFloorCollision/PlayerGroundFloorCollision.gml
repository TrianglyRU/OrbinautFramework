function PlayerGroundFloorCollision()
{	
	// Exit if collisions are disabled or we are standing on the object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Get current angle quadrant (shallower on floor and ceiling, comparing to wall collision)
	if Angle <= 45 or Angle >= 315
	{
		var Mode = 0;
	}
	else if Angle >= 46.41 and Angle <= 133.59
	{
		var Mode = 1;
	}
	else if Angle >= 135 and Angle <= 225
	{
		var Mode = 2;
	}
	else if Angle >= 226.41 and Angle <= 313.59
	{
		var Mode = 3;
	}
	
	// Collide with floor
	switch Mode
	{
		case 0:
		{		
			// Get nearest tile below us
			var FindFloor1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
			var FindFloor2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
		    var FindFloor3 = tile_compare(FindFloor1, FindFloor2, Angle);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FindFloor3[0] > Distance
				{
					if Animation == AnimMove
					{
						// Restart animation...?
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					break;
				}		
			}
			
			// Else collide
			if FindFloor3[0] >= -14
			{
				PosY += FindFloor3[0];
				Angle = FindFloor3[1];	
			}
		}
		break;
		case 1:
		{	
			// Get nearest tile to our right
			var FindFloor1 = tile_find_h(PosX + RadiusY, PosY + RadiusX, true, false, Layer);
			var FindFloor2 = tile_find_h(PosX + RadiusY, PosY - RadiusX, true, false, Layer);
			var FindFloor3 = tile_compare(FindFloor1, FindFloor2, Angle);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FindFloor3[0] > Distance
				{
					if Animation == AnimMove
					{
						// Restart animation...?
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					break;
				}	
			}
			
			// Else collide
			if FindFloor3[0] >= -14
			{
				PosX += FindFloor3[0];
				Angle = FindFloor3[1];	
			}
		}
		break;
		case 2:	
		{	
			// Get nearest tile above us
			var FindFloor1 = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, false, Layer);
			var FindFloor2 = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, false, Layer);
			var FindFloor3 = tile_compare(FindFloor1, FindFloor2, Angle);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FindFloor3[0] > Distance
				{
					if Animation == AnimMove
					{
						// Restart animation...?
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					break;
				}
			}
			
			// Else collide
			if FindFloor3[0] >= -14
			{	
				PosY -= FindFloor3[0];
				Angle = FindFloor3[1];
			}
		}
		break;
		case 3:
		{	
			// Get nearest tile to our left
			var FindFloor1 = tile_find_h(PosX - RadiusY, PosY - RadiusX, false, false, Layer);
			var FindFloor2 = tile_find_h(PosX - RadiusY, PosY + RadiusX, false, false, Layer);
			var FindFloor3 = tile_compare(FindFloor1, FindFloor2, Angle);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FindFloor3[0] > Distance
				{
					if Animation == AnimMove
					{
						// Restart animation...?
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					break;
				}
			}
				
			// Else collide
		    if FindFloor3[0] >= -14
			{
				PosX -= FindFloor3[0];
				Angle = FindFloor3[1];
			}
		}
		break;
	}
}