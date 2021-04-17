function PlayerCollideObjectsBottom()
{
	with TestObject3
	{
		// Exit if onject has no collision set
		if (!variable_instance_exists(id, "objectType")) exit;
		
		// Exit if no radiuses were initialized for the object
		if (!variable_instance_exists(id, "objYRadiusSolid")) exit;
		
		// Exit if we're already standing on this object
		if (Player.OnObject == id) exit;
		
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
		var playerLeft   = floor(Player.PosX - 11);
		var playerRight  = floor(Player.PosX + 11);
		var playerBottom = floor(Player.PosY + Player.yRadius);
		
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
				
			if image_yscale == -1
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
		if abs(objectX - playerX) + 4 > abs(objectY - playerY) - 4
		{
			exit;
		}
		
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
				Player.Ysp   = 0;
			}
		}
	}
}