/// @function object_player_touch(collisionSide)
function object_player_touch(collisionSide)
{
	// Exit the code if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit the code if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		exit;
	}
	
	// Exit the code if object can't be touched
	if !objXRadiusSolid or !objYRadiusSolid
	{
		return false;	
	}
	
	// Get object properties
	var objectX		   = floor(x);
	var objectY        = floor(y);
	var objectTop      = floor(y - objYRadiusSolid);
	var objectLeft     = floor(x - objXRadiusSolid);
	var objectRight    = floor(x + objXRadiusSolid);
	var objectBottom   = floor(y + objYRadiusSolid);	
	var objectMirrored = !image_xscale;
	var objectFlipped  = !image_yscale;
	var objectID	   = id;

	// Get player properties
	var playerX      = floor(Player.PosX);
	var playerY      = floor(Player.PosY);
	var playerTop    = floor(Player.PosY - Player.yRadius);
	var playerLeft   = floor(Player.PosX - 11);
	var playerRight  = floor(Player.PosX + 11);
	var playerBottom = floor(Player.PosY + Player.yRadius);
	
	// Adjust solidbox
	if !Game.ImprovedObjCollision
	{
		objectBottom += 1;
	}	
	else
	{
		objectRight -= 1;
	}
	
	// Set flags
	var objTouchedTop    = false;
	var objTouchedLeft   = false;
	var objTouchedRight  = false;
	var objTouchedBottom = false;
	
	// Return true if we're checking for SideTop and player is already standing on the object
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
			if playerY > objectY and playerTop < objectBottom
			{	
				objTouchedBottom = true;
			}
			
			// Check top touch result
			else if playerBottom < objectTop + 16
			{
				objTouchedTop = true;
			}
		}
		
		// Check horizontally
		else
		{
			// Check right touch
			if playerX > objectX
			{
				objTouchedRight = true;	
			}
				
			// Check left touch
			if playerX < objectX
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