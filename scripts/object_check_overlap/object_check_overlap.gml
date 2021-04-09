/// @function object_check_overlap(collisionType)
function object_check_overlap(collisionType)
{
	// Hitbox overlap
	if collisionType == CollisionHitbox
	{
		// Check if this object radiuses were initialized
		if !variable_instance_exists(id, "objXRadiusHit")
		{
			show_message("Object ID " + string(id) + " does not have any hitbox radiuses to check for collision with player! Please, call 'object_set_hitbox' function in Create event");
			game_end();
			exit;
		}
		
		// Calculate this object radiuses
		var objectTop    = y - objYRadiusHit;
		var objectLeft   = x - objXRadiusHit;
		var objectRight  = x + objXRadiusHit - 1;
		var objectBottom = y + objYRadiusHit - 1;
		
		// Check for overlap horizontally
		if floor(Player.PosX + 8) < objectLeft or floor(Player.PosX - 8) > objectRight
		{
			return false;
		}
		
		// Check for overlap vertically
		if floor(Player.PosY + Player.yRadius - 3) < objectTop or floor(Player.PosY - Player.yRadius + 3) > objectBottom
		{
			return false;
		}
		
		// If player overlaps object on both axis, they collided with it
		return true;
	}
	
	// Solidbox overlap
	else if collisionType == CollisionSolidbox
	{
		// Check if this object radiuses were initialized
		if !variable_instance_exists(id, "objXRadiusSolid")
		{
			show_message("Object ID " + string(id) + " does not have any solidbox radiuses to check for collision with player! Please, call 'object_set_solidbox' function in Create event");
			game_end();
			exit;
		}
		
		// Calculate this object radiuses
		var objectTop    = y - objYRadiusSolid;
		var objectLeft   = x - objXRadiusSolid;
		var objectRight  = x + objXRadiusSolid - 1;
		var objectBottom = y + objYRadiusSolid - 1;
		
		// Check for overlap horizontally
		if floor(Player.PosX + Player.xRadius) < objectLeft or floor(Player.PosX - Player.xRadius) > objectRight
		{
			return false;
		}
		
		// Check for overlap vertically
		if floor(Player.PosY + Player.yRadius) < objectTop or floor(Player.PosY - Player.yRadius) > objectBottom
		{
			return false;
		}
		
		// If player overlaps object on both axis, they collided with it
		return true;
	}
}