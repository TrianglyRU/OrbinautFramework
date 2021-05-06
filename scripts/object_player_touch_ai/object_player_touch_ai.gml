/// @function object_player_touch_ai(collisionSide)
function object_player_touch_ai(collisionSide)
{
	// Exit if there is no AI in the stage
	if (!instance_exists(AI)) exit;
	
	// Exit the code if collision is disabled
	if (!AI.AllowCollision) exit;
	
	// Exit the code if this object hitbox wasn't initialized
	if (!variable_instance_exists(id, "objXRadiusSolid")) exit;
	
	// Get object position and size
	var objectX		 = floor(x);
	var objectY      = floor(y);
	var objectTop    = floor(y - objYRadiusSolid - 1);
	var objectLeft   = floor(x - objXRadiusSolid);
	var objectRight  = floor(x + objXRadiusSolid - 1);
	var objectBottom = floor(y + objYRadiusSolid);
	
	// Get player position and size
	var playerX      = floor(AI.PosX);
	var playerY      = floor(AI.PosY);
	var playerTop    = floor(AI.PosY - AI.yRadius);
	var playerLeft   = floor(AI.PosX - 11);
	var playerRight  = floor(AI.PosX + 11);
	var playerBottom = floor(AI.PosY + AI.yRadius);
	
	// Set flags
	var objTouchedTop    = false;
	var objTouchedLeft   = false;
	var objTouchedRight  = false;
	var objTouchedBottom = false;
	
	// Return true if we're checking for SideTop and player is standing on the object
	if collisionSide == SideTop and AI.OnObject == id
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
			if playerX > x
			{
				objTouchedRight = true;	
			}
				
			// Check left touch
			if playerX < x
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