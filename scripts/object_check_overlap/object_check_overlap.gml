function object_check_overlap(checkFor, checkFrom)
{
	// Check if this object radiuses were initialized
	if !variable_instance_exists(checkFrom, "objXRadiusHit")
	{
		show_message("Object ID " + string(checkFrom) + " does not have any hitbox radiuses to check for collision with other instances! Please, call 'object_set_hitbox' function in Create event");
		game_end();
		exit;
	}
	
	// Get object size
	var objectTop    = floor(y - objYRadiusHit);
	var objectLeft   = floor(x - objXRadiusHit);
	var objectRight  = floor(x + objXRadiusHit - 1);
	var objectBottom = floor(y + objYRadiusHit - 1);
	
	// Check for overlap with player
	if checkFor == Player
	{
		// Get player hitbox size
		var playerTop    = floor(Player.PosY - Player.yRadius + 3);
		var playerLeft   = floor(Player.PosX - 8);
		var playerRight  = floor(Player.PosX + 8);
		var playerBottom = floor(Player.PosY + Player.yRadius - 3);
		
		// Check for overlap horizontally
		if playerRight < objectLeft or playerLeft > objectRight
		{
			return false;
		}
		
		// Check for overlap vertically
		if playerBottom < objectTop or playerTop > objectBottom
		{
			return false;
		}
		
		// If player overlaps object on both axis, they collided with it
		return true;
	}
	
	// Check for overlap with another object
	else
	{
		if !variable_instance_exists(checkFor, "objXRadiusHit")
		{
			show_message("Object ID " + string(checkFor) + " does not have any hitbox radiuses to check for collision! Please, call 'object_set_hitbox' function in Create event");
			game_end();
			exit;
		}
		
		// Get target object size
		var targetTop    = floor(checkFor.y - checkFor.objYRadiusHit);
		var targetLeft   = floor(checkFor.x - checkFor.objXRadiusHit);
		var targetRight  = floor(checkFor.x + checkFor.objXRadiusHit - 1);
		var targetBottom = floor(checkFor.y + checkFor.objYRadiusHit - 1);
		
		// Check for overlap horizontally
		if targetRight < objectLeft or targetLeft > objectRight
		{
			return false;
		}
		
		// Check for overlap vertically
		if targetBottom < objectTop or targetTop > objectBottom
		{
			return false;
		}
		
		// If another overlaps object on both axis, it collided with this object
		return true;
	}	
}