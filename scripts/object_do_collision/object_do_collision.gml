/// @function object_do_collision(objectType, collisionMap)
function object_do_collision(objectType, collisionMap)
{
	// Check if this object radiuses were initialized
	if variable_instance_exists(id, "objXRadiusSolid") == false
	{
		show_message("Object ID " + string(id) + " does not have any radiuses to check for collision with player! Please, call 'object_set_solidbox' function in Create event");
		game_end();
		exit;
	}
	
	// Don't do anything if this object does not have collision
	if (objectType = SolidNone) exit;
	
	// Calculate this object radiuses and diameters
	var objectTop    = y - objYRadiusSolid;
	var objectLeft   = x - objXRadiusSolid;
	var objectRight  = x + objXRadiusSolid - 1;
	var objectBottom = y + objYRadiusSolid - 1;

	// Check if player is standing on this object
	if Player.OnObject == id
	{	
		// Extend edges if this is not SolidTop object
		var edgeExtension = objectType == SolidTop ? 0 : 10;
		
		// Check if player is outside of this object boundaries
		if floor(Player.PosX + edgeExtension) < objectLeft 
		or floor(Player.PosX - edgeExtension) > objectRight
		{
			Player.OnObject = false;
		}

		// Else keep player attached
		else
		{
			// If collisionMap is assigned, define new top boundary of this object, based on current player position within it
			if collisionMap != false and image_yscale == 1
			{
				var playerPosition = image_xscale == 1 ? floor(Player.PosX) - objectLeft : objectRight - floor(Player.PosX);
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

			// Attach player to this object's top boundary
			Player.PosY = objectTop - Player.yRadius - 1;
		}
	}
	
	// If player is not standing on this object, collide with it
	else
	{
		// Check type of this object
		if objectType == SolidAll
		{
			// Check for overlap with this object horizontally
			if floor(Player.PosX + 10) < objectLeft or floor(Player.PosX - 10) > objectRight
			{
				exit;
			}
			
			// Check for player's position
			if collisionMap != false
			{
				var playerPosition = image_xscale == 1 ? floor(Player.PosX) - objectLeft : objectRight - floor(Player.PosX);
				
				if image_yscale == 1
				{
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
				else if image_yscale == -1
				{
					if  playerPosition < 0
					{
						var objectBottom = y + collisionMap[0];
					}
					else if playerPosition > objXRadiusSolid * 2
					{
						var objectBottom = y + collisionMap[objXRadiusSolid * 2];
					}
					else
					{
						var objectBottom = y + collisionMap[playerPosition];
					}
				}
			}
																   
			// Check for overlap with this object vertically
			if floor(Player.PosY + Player.yRadius) < objectTop - 4 or floor(Player.PosY - Player.yRadius) > objectBottom
			{
				exit;
			}

			// Collide with this object vertically
			if abs(x - floor(Player.PosX)) <= abs(y - floor(Player.PosY) - 4) 	
			{
				// Check if player is below this object
				if floor(Player.PosY) > y
				{	
					// If player is grounded, kill him
					if Player.Grounded == true
					{
						Player.Rings = 0;
						Player.Hurt  = true;
					}

					// Else push player out from this object
					else
					{
						if Player.Ysp < 0 and floor(Player.PosY - Player.yRadius) < objectBottom
						{
							Player.PosY = objectBottom + Player.yRadius + 1;
							Player.Ysp  = 0;
						}
					}
				}

				// Check if player is above this object and not 16 pixels into it
				else if floor(Player.PosY + Player.yRadius) < objectTop + 16
				{	
					// Check if player's position is within this object boundaries
					if floor(Player.PosX) < objectLeft or floor(Player.PosX) > objectRight
					{
						exit;
					}

					// Check if player is moving downwards or standing still
					if Player.Ysp < 0
					{
						exit;
					}

					// If player is airborne, let him land on this object	
					if Player.Grounded == false
					{
						Player.Grounded = true;
						with Player PlayerResetOnFloor();	// force call player's script
					}

					// Set flags and speeds for player
					Player.OnObject = id;
					Player.Inertia  = Player.Xsp;
					Player.Angle    = 360;
					Player.Ysp      = 0;
					
					// Attach player to the object's top boundary
					Player.PosY = objectTop - Player.yRadius - 1;
				}
			}
	
			// Collide with this object horizontally
			else
			{
				// Collide on the right
				if floor(Player.PosX) > x
				{
					if Player.Xsp < 0
					{
						Player.Xsp	   = 0;
						Player.Inertia = 0;
					}
					Player.PosX = objectRight + 11;
				}
				
				// Collide on the left
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
			// Check if player is moving downwards or standing still
			if Player.Ysp < 0
			{
				exit;
			}
			
			// Check if player's position is within this object boundaries
			if floor(Player.PosX) < objectLeft or floor(Player.PosX) > objectRight
			{
				exit;
			}
			
			// Check if player's bottom has overlapped this object's top boundary
			if objectTop - 4 > floor(Player.PosY + Player.yRadius)
			{
				exit;
			}
			
			// Check if player's bottom is maximum 16 pixels into this object
			if objectTop - 4 - floor(Player.PosY + Player.yRadius) < -16
			or objectTop - 4 - floor(Player.PosY + Player.yRadius) > 0
			{
				exit;
			}
			
			// If player is airborne, let him land on this object	
			if Player.Grounded == false
			{
				Player.Grounded = true;
				with Player PlayerResetOnFloor();	// force call player's script
			}
			
			// Set flags and speeds for player
			Player.OnObject = id;
			Player.Inertia  = Player.Xsp;
			Player.Angle    = 360;
			Player.Ysp      = 0;
			
			// If collisionMap is assigned, define new top boundary of this object, based on current player position within it
			if collisionMap != false and image_yscale == 1
			{
				var playerPosition = image_xscale == 1 ? floor(Player.PosX) - objectLeft : objectRight - floor(Player.PosX);
				var objectTop      = y - collisionMap[playerPosition];
			}
			
			// Attach player to the object's top boundary
			Player.PosY = objectTop - Player.yRadius - 1;
		}
	}
}