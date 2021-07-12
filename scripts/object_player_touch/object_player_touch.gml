/// @function object_player_touch(collisionSide)
function object_player_touch(collisionSide)
{
	// Exit the code if collision is disabled
	if !Player.AllowCollision 
	{
		exit;
	}
	
	// Exit the code if this object hitbox wasn't initialized
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		exit;
	}
	
	// Get object position and size
	var objectX		 = floor(x);
	var objectY      = floor(y);
	var objectTop    = floor(y - objYRadiusSolid - 1);
	var objectLeft   = floor(x - objXRadiusSolid);
	var objectRight  = floor(x + objXRadiusSolid - 1);
	var objectBottom = floor(y + objYRadiusSolid);
	var objectID	 = id;
	
	// Get player position and size
	var playerX      = floor(Player.PosX);
	var playerY      = floor(Player.PosY);
	var playerTop    = floor(Player.PosY - Player.yRadius);
	var playerLeft   = floor(Player.PosX - 11);
	var playerRight  = floor(Player.PosX + 11);
	var playerBottom = floor(Player.PosY + Player.yRadius);
	
	// Set flags
	var objTouchedTop    = false;
	var objTouchedLeft   = false;
	var objTouchedRight  = false;
	var objTouchedBottom = false;
	
	// Return true if we're checking for SideTop and player is standing on the object
	if collisionSide == SideTop and Player.OnObject == objectID
	{
		return true;
	}
	else
	{
		// Check for object overlap
		if playerRight < objectLeft or playerLeft > objectRight
		{
			exit;
		}
		if playerBottom < objectTop or playerTop > objectBottom
		{
			exit;
		}
		
		// Check vertically
		if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4
		{
			// Check bottom touch
			if playerY > objectY and playerTop < objectBottom and Player.Ysp <= 0
			{	
				objTouchedBottom = true;
			}
			
			// Check top touch result
			else if playerBottom < objectTop + 16 and Player.Ysp >= 0
			{
				objTouchedTop = true;
			}
		}
		
		// Check horizontally
		else
		{
			// Check right touch
			if playerX > objectX and Player.Xsp >= 0
			{
				objTouchedRight = true;	
			}
				
			// Check left touch
			if playerX < objectX and Player.Xsp <= 0
			{	
				objTouchedLeft = true;
			}		
		}
	
		// Return check result
		switch collisionSide
		{
			case SideTop:    return objTouchedTop;    break;
			case SideLeft:   return objTouchedLeft;   break;
			case SideRight:  return objTouchedRight;  break;
			case SideBottom: return objTouchedBottom; break;
		}
	}
}