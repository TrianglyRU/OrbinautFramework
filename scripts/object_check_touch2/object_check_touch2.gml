function object_check_touch2(collisionSide)
{
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any solidbox radiuses to check for collision with player! Please, call 'object_set_solidbox' function in Create event");
		game_end();
		exit;
	}
	
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
	
	objTouchedTop    = false;
	objTouchedLeft   = false;
	objTouchedRight  = false;
	objTouchedBottom = false;

	if Player.OnObject == id
	{	
		objTouchedTop = true;
	}
	else
	{
		if objectType == SolidAll
		{
			if playerRight < objectLeft or playerLeft > objectRight
			{
				exit;
			}
			if collisionMap != false
			{
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
			
			if playerBottom < objectTop or playerTop > objectBottom
			{
				exit;
			}
			
			if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4
			{
				if playerY > objectY and playerTop < objectBottom
				{	
					objTouchedBottom = true;
				}
			}
			else
			{
				// Collide on the right
				if playerX > x
				{
					objTouchedRight = true;	
				}
				
				// Collide on the left
				if playerX < x
				{	
					objTouchedLeft = true;
				}		
			}
		}
	}
	
	// Return collision result
	switch collisionSide
	{
		case SideTop:    return objTouchedTop;    break;
		case SideLeft:   return objTouchedLeft;   break;
		case SideRight:  return objTouchedRight;  break;
		case SideBottom: return objTouchedBottom; break;
	}
}