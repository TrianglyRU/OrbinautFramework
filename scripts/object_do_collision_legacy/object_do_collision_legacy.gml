/// @function object_do_collision_legacy(objectType, collisionMap)
function object_do_collision_legacy(objectType, collisionMap)
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
	var xRadius   = objXRadiusSolid + 11;
	var yRadius   = objYRadiusSolid + Player.yRadius;
	var xDiameter = xRadius * 2;
	var yDiameter = yRadius * 2;
		
	//* ON-OBJECT COLLISION *//
	// ===================== //
	
	if Player.OnObject == id
	{
		// Check if player is inside our boundaries, use smaller boundaries if we're SolidTop object
		var edgeLeft  = 0;
		var edgeRight = objectType == SolidAll ? xDiameter : objXRadiusSolid * 2;
		var edgeDistance = floor(Player.PosX) - x + edgeRight / 2;
		
		// If not, player does not standing on us anymore		
		if edgeDistance < edgeLeft or edgeDistance >= edgeRight
		{
			Player.OnObject = false;
			Player.Grounded = false;
		}
		
		// else keep them attached to us
		else
		{
			var test1 = floor(Player.PosX) - x + objXRadiusSolid;
			var colYRadius = collisionMap == false ? objYRadiusSolid : collisionMap[test1];
			show_debug_message(test1);
			show_debug_message(colYRadius);
			Player.PosY = y - colYRadius - Player.yRadius - 1;
		}
	}
	else
	{
		//* CHECK FOR OVERLAP *//
		// =================== //
		
		if objectType == SolidAll
		{
			// Check for overlapping with player horizontally
			var leftDifference = floor(Player.PosX) - x + xRadius;
			if (leftDifference < 0 or leftDifference > xDiameter) exit;
			
			// Check for overlapping with player vertically
			if collisionMap == false
			{
				var topDifference = floor(Player.PosY) - y + yRadius + 4;
				if (topDifference < 0 or topDifference > yDiameter) exit;
			}
			else
			{
				var test1 = floor(Player.PosX) - x + objXRadiusSolid;
				if test1 < 0 or test1 > objYRadiusSolid * 2 exit;
	
				var topDifference = floor(Player.PosY) - y + collisionMap[test1] + 4;
				if (topDifference < 0 or topDifference > yDiameter) exit;
			}
			
			//* FIND DIRECTION OF COLLISION *//
			// ============================= //
	
			// Get distance to our centre
			var xDistance = floor(Player.PosX > x) ? leftDifference - xDiameter : leftDifference;
			var yDistance = floor(Player.PosY > y) ? topDifference - yDiameter - 4 : topDifference;
	
			//* COLLIDE *//
			// ========= //
	
			// Collide vertically
			if abs(xDistance) > abs(yDistance)
			{
				// Check if player below us and if we are full solid object
				if floor(Player.PosY) > y
				{	
					// If they are grounded, kill them
					if Player.Grounded == true
					{
						Player.Rings = 0;
						Player.Hurt  = true;
					}
				
					// Else push them out
					else if Player.Ysp < 0 and yDistance < 0
					{
						Player.PosY -= yDistance;
						Player.Ysp   = 0;
					}
				}
			
				// Check if player above us and not 16 pixels inside
				else if yDistance < 16
				{	
					// Check if player's X is inside our boundaries
					var xComparison = floor(Player.PosX) - x + objXRadiusSolid;
					if  xComparison >= 0 and xComparison < objXRadiusSolid * 2
					{
						// If player's y speed is positive, let them land on us
						if Player.Ysp >= 0
						{		
							// Set flags
							Player.OnObject = id;
							Player.Grounded = true;
					
							// Call PlayerResetOnFloor script. Normally, we do not call scripts in Orbinaut, we have to do it here
							with Player PlayerResetOnFloor();
					
							// Set player's speeds
							Player.Inertia = Player.Xsp;
							Player.Angle   = 360;
							Player.Ysp     = 0;
							
							var colYRadius = collisionMap == false ? objYRadiusSolid : collisionMap[xComparison];
							Player.PosY    = y - colYRadius - Player.yRadius - 1;
						}
					}
				}
			}
	
			// Collide horizontally
			else if abs(yDistance) > 4 and xDistance != 0
			{
				// Collide on the left
				if floor(Player.PosX) > x
				{
					if Player.Xsp < 0
					{
						Player.Xsp	   = 0;
						Player.Inertia = 0;
					}
					Player.PosX -= xDistance;
				}
			
				// Collide on the right
				else
				{
					if Player.Xsp > 0
					{
						Player.Xsp	   = 0;
						Player.Inertia = 0;
					}
					Player.PosX -= xDistance;
				}		
			}
		}
		else if objectType == SolidTop
		{	
			// Check if player is standing still or moving downwards
			if (Player.Ysp < 0) exit;
				
			// Check if player is overlapping us horizontally
			var xComparison = (x + objXRadiusSolid) - floor(Player.PosX);
			if  xComparison < 0 or xComparison >= objXRadiusSolid * 2
			{
				exit;
			}
	
			// Check if player is overlapping us vertically
			var objectSurface = y - objYRadiusSolid;
			var playerBottom  = floor(Player.PosY + Player.yRadius + 4);
			
			if (objectSurface > playerBottom) exit;
			
			var yComparison = objectSurface - playerBottom;
			if  yComparison < -16 or yComparison >= 0
			{
				exit;
			}
			
			// Set flags
			Player.OnObject = id;
			Player.Grounded = true;
					
			// Call PlayerResetOnFloor script. Normally, we do not call scripts in Orbinaut, we have to do it here
			with Player PlayerResetOnFloor();
					
			// Set player's speeds
			Player.Inertia = Player.Xsp;
			Player.Angle   = 360;
			Player.Ysp     = 0;
			Player.PosY    = y - objYRadiusSolid - Player.yRadius - 1;
			
			if collisionMap != false
			{
				Player.PosY += collisionMap[xComparison];
			}	
		}
	}
}