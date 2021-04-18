/// @function object_check_touch(collisionSide)
function object_check_touch(collisionSide)
{
	// Exit if collision is disabled
	if (!Player.AllowCollision) exit;
	
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
	
	var objTouchedTop    = false;
	var objTouchedLeft   = false;
	var objTouchedRight  = false;
	var objTouchedBottom = false;

	if playerRight < objectLeft or playerLeft > objectRight
	{
		exit;
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
		else if playerBottom < objectTop + 16
		{
			objTouchedTop = true;
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
	
	// Return collision result
	switch collisionSide
	{
		case SideTop:    return objTouchedTop;    break;
		case SideLeft:   return objTouchedLeft;   break;
		case SideRight:  return objTouchedRight;  break;
		case SideBottom: return objTouchedBottom; break;
	}
}