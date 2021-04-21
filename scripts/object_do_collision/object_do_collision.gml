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
	
	// Set debug flags
	hasArrayMap  = collisionMap;
	isCollidable = false;
	objType      = objectType;
	
	// Don't do anything if this object does not have collision
	if (objectType = SolidNone)
	{
		if (Player.OnObject) Player.OnObject = false;
		exit;
	}
	
	// Update debug flag
	isCollidable = true;
	
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
			
	// Check if player is standing on this object
	if Player.OnObject == id
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
					
		// Move player alongside the object horizontal movement
		Player.PosX += floor(x - xprevious);
		playerX		 = floor(Player.PosX);
						
		// Make player to always stay on the object level
		Player.PosY = objectTop - Player.yRadius;
					
		// Check if player should enter their balancing action
		if Player.Inertia == 0
		{
			if playerX <= objectLeft  + 4 and Player.Facing == DirLeft
			or playerX >= objectRight - 4 and Player.Facing == DirRight
			{
				Player.Balancing = DirRight;
			}
			else if playerX <= objectLeft  + 4 and Player.Facing == DirRight
				or playerX >= objectRight - 4 and Player.Facing == DirLeft
				{
					Player.Balancing = DirLeft;
				}
			else
			{
				Player.Balancing = false;
			}
		}
		else
		{
			Player.Balancing = false;
		}
				
		// Extend edges if this is not SolidTop object
		var edgeExtension = objectType == SolidTop ? 0 : 10;
				
		// Check if player is outside of this object boundaries
		if playerX + edgeExtension < objectLeft 
		or playerX - edgeExtension > objectRight
		{
			Player.OnObject = false;
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
			if playerBottom < objectTop or playerTop > objectBottom
			{
				exit;
			}
					
			// Collide with this object vertically
			if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4
			{
				// Check if player is below this object
				if playerY > objectY and playerTop < objectBottom
				{	
					// If player is grounded, kill them
					if Player.Grounded
					{
						object_do_damage(true);
					}

					// Else push player out from this object
					else if Player.Ysp < 0
					{
						Player.PosY += objectBottom - playerTop;
						Player.Ysp  = 0;
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
							
					Player.Pushing  = DirLeft;
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
							
					Player.Pushing  = DirRight;
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
					
			// Attach player to the object's top boundary
			if collisionMap != false and image_yscale == 1
			{
				var playerPosition = image_xscale == 1 ? playerX - objectLeft : objectRight - playerX;
				var objectTop      = y - collisionMap[playerPosition];
				Player.PosY        = objectTop - Player.yRadius - 1;
			}
			else
			{
				Player.PosY = objectTop - Player.yRadius;
			}
		}
	}
}