function PlayerCollideObjectsLeft()
{
	with TestObject3
	{
		// Exit if onject has no collision set
		if (!variable_instance_exists(id, "objectType")) exit;
		
		// Exit if no radiuses were initialized for the object
		if (!variable_instance_exists(id, "objXRadiusSolid")) exit;
		
		// Exit if we're already standing on this object
		if (Player.OnObject == id) exit;

		// Get object position and size
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
	
		// Check for overlap with this object vertically
		if playerBottom < objectTop or playerTop > objectBottom
		{
			exit;
		}
	
		// Collide with this object vertically
		if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4
		{
			exit;
		}
	
		// Collide on the left
		if playerX < x
		{	
			if Player.Xsp > 0
			{
				Player.Xsp = 0;
				if (Player.Grounded) Player.Inertia = 0;		
			}
			Player.PosX -= playerRight - objectLeft;
					
			// Tell this object player touched its left side
			Player.Pushing  = DirRight;
		}
	}
}