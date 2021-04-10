/// @function object_do_collision(objectType, collisionMap)
function object_do_collision(objectType, collisionMap)
{
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any solidbox radiuses to check for collision with player! Please, call 'object_set_solidbox' function in Create event");
		game_end();
		exit;
	}
	
	// Don't do anything if this object does not have collision
	if (objectType = SolidNone) exit;
	
	// Get object position and size
	var objectX		 = floor(x);
	var objectY      = floor(y);
	var objectTop    = floor(y - objYRadiusSolid - 1);
	var objectLeft   = floor(x - objXRadiusSolid);
	var objectRight  = floor(x + objXRadiusSolid - 1);
	var objectBottom = floor(y + objYRadiusSolid);
	
	// Get player position and size
	var playerX      = floor(Player.PosX);
	var playerY      = floor(Player.PosY);
	var playerTop    = floor(Player.PosY - Player.yRadius);
	var playerLeft   = floor(Player.PosX - 11);
	var playerRight  = floor(Player.PosX + 11);
	var playerBottom = floor(Player.PosY + Player.yRadius);
	
	// Reset touched flags
	objTouchedTop    = false;
	objTouchedLeft   = false;
	objTouchedRight  = false;
	objTouchedBottom = false;

	// Check if player is standing on this object
	if Player.OnObject == id
	{	
		// Tell this object player touches its top side
		objTouchedTop = true;
		
		// Extend edges if this is not SolidTop object
		var edgeExtension = objectType == SolidTop ? 0 : 10;
		
		// Check if player is outside of this object boundaries
		if playerX + edgeExtension < objectLeft 
		or playerX - edgeExtension > objectRight
		{
			Player.OnObject = false;
		}

		// Else keep player attached
		else
		{
			
			// If collisionMap is assigned, define new top boundary of this object, based on current player position within it
			if collisionMap != false and image_yscale == 1
			{
				var playerPosition = image_xscale == 1 ? playerX - objectLeft : objectRight - playerX;
				if  playerPosition < 0
				{
					objectTop = objectY - collisionMap[0] - 1;
				}
				else if playerPosition > objXRadiusSolid * 2
				{
					objectTop = objectY - collisionMap[objXRadiusSolid * 2] - 1;
				}
				else
				{
					objectTop = objectY - collisionMap[playerPosition] - 1;
				}
			}

			// Attach player to this object's top boundary
			Player.PosY = objectTop - Player.yRadius;
		}
	}
	
	// If player is not standing on this object, collide with it
	else
	{
		// Check type of this object
		if objectType == SolidAll
		{
			// Check for overlap with this object horizontally
			if playerRight < objectLeft or playerLeft > objectRight
			{
				exit;
			}
			
			// If collisionMap is assigned, define new top boundary of this object, based on current player position within it
			if collisionMap != false
			{
				// Get player poisition
				var playerPosition = image_xscale == 1 ? playerX - objectLeft : objectRight - playerX;
				
				// Check top object boundary
				if image_yscale == 1
				{
					if  playerPosition < 0
					{
						objectTop = objectY - collisionMap[0] - 1;
					}
					else if playerPosition > objXRadiusSolid * 2
					{
						objectTop = objectY - collisionMap[objXRadiusSolid * 2] - 1;
					}
					else
					{
						objectTop = objectY - collisionMap[playerPosition] - 1;
					}
				}
				
				// Adjust bottom object boundary
				else if image_yscale == -1
				{
					if  playerPosition < 0
					{
						objectBottom = objectY + collisionMap[0];
					}
					else if playerPosition > objXRadiusSolid * 2
					{
						objectBottom = objectY + collisionMap[objXRadiusSolid * 2];
					}
					else
					{
						objectBottom = objectY + collisionMap[playerPosition];
					}
				}
			}
			
			// Check for overlap with this object vertically
			if playerBottom < objectTop - 4 or playerTop > objectBottom
			{
				exit;
			}
			
			// Collide with this object vertically
			if abs(objectX - playerX) <= abs(objectY - playerY)	
			{
				// Check if player is below this object
				if playerY > objectY and playerTop < objectBottom
				{	
					// If player is grounded, kill him
					if Player.Grounded
					{
						Player.Rings = 0;
						Player.Hurt  = id;
					}

					// Else push player out from this object
					else if Player.Ysp < 0
					{
						Player.PosY += objectBottom - playerTop;
						Player.Ysp  = 0;
							
						// Tell this object player touched its bottom side
						objTouchedBottom = true;
					}
				}

				// Check if player is above this object and not 16 pixels into it
				else if playerBottom < objectTop + 16
				{	
					// Check if player's position is within this object boundaries
					if playerX < objectLeft or playerX > objectRight
					{
						exit;
					}

					// Check if player is moving downwards or standing still
					if Player.Ysp < 0
					{
						exit;
					}

					// If player is airborne, let him land on this object	
					if !Player.Grounded
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
					Player.PosY = objectTop - Player.yRadius;
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
						Player.Xsp = 0;
						if (Player.Grounded) Player.Inertia = 0;	
					}
					Player.PosX += objectRight - playerLeft;
					
					// Tell this object player touched its right side
					objTouchedRight = true;		
				}
				
				// Collide on the left
				if floor(Player.PosX) < x
				{	
					if Player.Xsp > 0
					{
						Player.Xsp = 0;
						if (Player.Grounded) Player.Inertia = 0;		
					}
					Player.PosX -= playerRight - objectLeft;
					
					// Tell this object player touched its left side
					objTouchedLeft = true;
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
			if playerX < objectLeft or playerX > objectRight
			{
				exit;
			}
			
			// If collisionMap is assigned, define new top boundary of this object, based on current player position within it
			if collisionMap != false
			{
				// Get player poisition
				var playerPosition = image_xscale == 1 ? playerX - objectLeft : objectRight - playerX;
				
				// Check top object boundary
				if image_yscale == 1
				{
					if  playerPosition < 0
					{
						objectTop = objectY - collisionMap[0] - 1;
					}
					else if playerPosition > objXRadiusSolid * 2
					{
						objectTop = objectY - collisionMap[objXRadiusSolid * 2] - 1;
					}
					else
					{
						objectTop = objectY - collisionMap[playerPosition] - 1;
					}
				}
			}
			
			// Check if player's bottom has overlapped this object's top boundary
			if playerBottom < objectTop - 4 or playerBottom >= objectTop + 16
			{
				exit;
			}
			
			// If player is airborne, let him land on this object	
			if !Player.Grounded
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
				var playerPosition = image_xscale == 1 ? playerX - objectLeft : objectRight - playerX;
				var objectTop      = y - collisionMap[playerPosition];
			}
			
			// Attach player to the object's top boundary
			Player.PosY = objectTop - Player.yRadius;
			
			// Tell this object player touched its top side
			objTouchedTop = true;
		}
	}
}