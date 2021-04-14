/// @function object_check_overlap(collisionType)
function object_check_overlap(collisionType)
{
	// Check for hitbox overlap
	if collisionType == CollisionHitbox
	{
		// Check if this object radiuses were initialized
		if !variable_instance_exists(id, "objXRadiusHit")
		{
			show_message("Object ID " + string(id) + " does not have any hitbox radiuses to check for collision with player! Please, call 'object_set_hitbox' function in Create event");
			game_end();
			exit;
		}
	
		// Get object size
		var objectTop    = floor(y - objYRadiusHit);
		var objectLeft   = floor(x - objXRadiusHit);
		var objectRight  = floor(x + objXRadiusHit - 1);
		var objectBottom = floor(y + objYRadiusHit - 1);
		
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
	
	// Check for triggerbox overlap
	else if collisionType == CollisionTriggerbox
	{
		// Check if this object triggerbox was initialized
		if !variable_instance_exists(id, "objXRadiusTriggerLeft")
		{
			show_message("Object ID " + string(id) + " does not have triggerbox to check for collision with player! Please, call 'object_set_triggerbox' function in Create event");
			game_end();
			exit;
		}
		
		// Return collision result
		return point_in_rectangle(floor(Player.PosX), floor(Player.PosY), floor(x + objXRadiusTriggerLeft), floor(y + objYRadiusTriggerTop), floor(x + objXRadiusTriggerRight - 1), floor(y + objYRadiusTriggerBottom - 1));
	}
}