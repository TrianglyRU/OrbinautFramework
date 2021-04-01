/// @function object_do_collision(objectType, collisionMap)
function object_do_collision(objectType, collisionMap)
{
	// Check if object's radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusSolid") or !variable_instance_exists(id, "objYRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any radiuses to check for collision with player!");
		game_end();
		exit;
	}
	
	// Don't do anything if we do not have collision
	if (objectType = SolidNone) exit;
	
	// Calculate our radiuses and diameters
	var objectTop    = y - objYRadiusSolid;
	var objectLeft   = x - objXRadiusSolid;
	var objectRight  = x + objXRadiusSolid - 1;
	var objectBottom = y + objYRadiusSolid - 1;

	// Check if we're on this object
	if Player.OnObject == id
	{	
		var edgeExtension = objectType != SolidTop ? 10 : 0;
		
		if floor(Player.PosX + edgeExtension) < objectLeft 
		or floor(Player.PosX - edgeExtension) > objectRight
		{
			Player.OnObject = false;
		}
		else
		{
			if collisionMap != false
			{
				var playerPosition = floor(Player.PosX) - objectLeft;
				if  playerPosition < 0
				{
					var objectTop = y - collisionMap[0];
				}
				else if playerPosition > objXRadiusSolid * 2
				{
					var objectTop = y - collisionMap[objXRadiusSolid * 2];
				}
				else
				{
					var objectTop = y - collisionMap[playerPosition];
				}
			}
			Player.PosY  = objectTop - Player.yRadius - 1;
		}
	}
	
	// Else collide
	else
	{
		if objectType == SolidAll
		{
			// Check for overlap
			if floor(Player.PosX + 10) < objectLeft or floor(Player.PosX - 10) > objectRight
			{
				exit;
			}
			if floor(Player.PosY + Player.yRadius) < objectTop - 4 or floor(Player.PosY - Player.yRadius) > objectBottom
			{
				exit;
			}

			// Collide
			if abs(x - floor(Player.PosX)) <= abs(y - floor(Player.PosY) - 4) 	
			{
				if floor(Player.PosY) > y
				{	
					if Player.Grounded == true
					{
						Player.Rings = 0;
						Player.Hurt  = true;
					}
					else if Player.Ysp < 0 and floor(Player.PosY - Player.yRadius) < objectBottom
					{
						Player.PosY = objectBottom + Player.yRadius + 1;
						Player.Ysp  = 0;
					}
				}
				else if floor(Player.PosY + Player.yRadius) < objectTop + 16
				{	
					if floor(Player.PosX) >= objectLeft and floor(Player.PosX) <= objectRight
					{
						if Player.Ysp >= 0
						{		
							if Player.Grounded == false
							{
								Player.Grounded = true;
								with Player PlayerResetOnFloor();
							}
							Player.OnObject = id;
					
							Player.Inertia = Player.Xsp;
							Player.Angle   = 360;
							Player.Ysp     = 0;
							
							if collisionMap != false
							{
								var playerPosition = floor(Player.PosX) - objectLeft;
								var objectTop      = y - collisionMap[playerPosition];
							}
							Player.PosY = objectTop - Player.yRadius - 1;
						}
					}
				}
			}
	
			// Collide horizontally
			else
			{
				if floor(Player.PosX) > x
				{
					if Player.Xsp < 0
					{
						Player.Xsp	   = 0;
						Player.Inertia = 0;
					}
					Player.PosX = objectRight + 11;
				}
				else
				{
					if Player.Xsp > 0
					{
						Player.Xsp	   = 0;
						Player.Inertia = 0;
					}
					Player.PosX = objectLeft - 11;
				}		
			}
		}
		else if objectType == SolidTop
		{
			if Player.Ysp < 0
			{
				exit;
			}
			if floor(Player.PosX) < objectLeft or floor(Player.PosX) > objectRight
			{
				exit;
			}
			
			if objectTop - 4 > floor(Player.PosY + Player.yRadius)
			{
				exit;
			}
			
			if objectTop - 4 - floor(Player.PosY + Player.yRadius) < -16
			or objectTop - 4 - floor(Player.PosY + Player.yRadius) > 0
			{
				exit;
			}
			
			if Player.Grounded == false
			{
				Player.Grounded = true;
				with Player PlayerResetOnFloor();
			}
			Player.OnObject = id;
					
			Player.Inertia = Player.Xsp;
			Player.Angle   = 360;
			Player.Ysp     = 0;
							
			if collisionMap != false
			{
				var playerPosition = floor(Player.PosX) - objectLeft;
				var objectTop      = y - collisionMap[playerPosition];
			}
			Player.PosY = objectTop - Player.yRadius - 1;
		}
	}
}