function PlayerCollideObjectsTop()
{
	// Perform the code from object side
	with TestObject3
	{
		// Exit if onject has no collision set
		if (!variable_instance_exists(id, "objectType")) exit;
		
		// Exit if no radiuses were initialized for the object
		if (!variable_instance_exists(id, "objYRadiusSolid")) exit;
		
		show_debug_message("Kek" + string(id));
		
		// Set local variables
		var objectX		 = floor(x);
		var objectY      = floor(y);
		var objectTop    = floor(y - objYRadiusSolid - 1);
		var objectLeft   = floor(x - objXRadiusSolid);
		var objectRight  = floor(x + objXRadiusSolid - 1);
		var objectBottom = floor(y + objYRadiusSolid);
		var playerX      = floor(Player.PosX);
		var playerY      = floor(Player.PosY);
		var playerTop    = floor(Player.PosY - Player.yRadius);
		var playerBottom = floor(Player.PosY + Player.yRadius);
		
		// Check if player is standing on the object
		if Player.OnObject == id
		{
			// Use collision height array if it is assigned for the object
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
			
			// Update playerX variable
			playerX = floor(Player.PosX);
			
			// Attach player to the object's top
			Player.PosY = objectTop - Player.yRadius;
			
			// Check if player should start balancing
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
			}
			else
			{
				Player.Balancing = false;
			}
		
			// Extend edges if this is not SolidTop object
			var edgeExtension = objectType == SolidTop ? 0 : 10;
		
			// Lose the object if player is outside of its boundaries
			if playerX + edgeExtension < objectLeft 
			or playerX - edgeExtension > objectRight
			{
				Player.OnObject = false;
			}
		}
		
		// Check if player is not standing on the object
		else if Player.OnObject != id
		{
			// Check if player's position is within this object boundaries
			if playerX < objectLeft or playerX > objectRight
			{
				exit;
			}
			
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
			
			// Check for overlap with this object vertically
			if playerBottom < objectTop or playerTop > objectBottom
			{
				exit;
			}
			
			// Collide with this object vertically
			if abs(objectX - playerX) + 4 > abs(objectY - playerY) - 4
			{	
				exit;
			}
			
			if playerY <= objectY and playerBottom < objectTop + 16
			{	
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
				Player.PosY = objectTop - Player.yRadius - 1;
			}
		}
	}
}