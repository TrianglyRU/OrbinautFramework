/// @function object_player_overlap(collisionType)
function object_player_overlap(collisionType)
{	
	// Exit the code if collision is disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Check for hitbox overlap
	if collisionType == CollisionHitbox
	{
		// Exit the code if this object hitbox wasn't initialized
		if !variable_instance_exists(id, "objXRadiusHit")
		{
			exit;
		}
	
		// Get object size
		var objectTop    = floor(y - objYRadiusHit);
		var objectLeft   = floor(x - objXRadiusHit);
		var objectRight  = floor(x + objXRadiusHit);
		var objectBottom = floor(y + objYRadiusHit);
		
		// Check if we should adjust it
		if Game.ImprovedObjCollision
		{
			objectRight -= 1;
			objectLeft  -= 1;
		}
		
		// Get player hitbox size
		if Player.Animation == AnimCrouch
		{
			var playerTop    = floor(Player.PosY - 4);
			var playerLeft   = floor(Player.PosX - 8);
			var playerRight  = floor(Player.PosX + 8);
			var playerBottom = floor(Player.PosY + 16);		
		}
		else
		{
			var playerTop    = floor(Player.PosY - Player.yRadius + 3);
			var playerLeft   = floor(Player.PosX - 8);
			var playerRight  = floor(Player.PosX + 8);
			var playerBottom = floor(Player.PosY + Player.yRadius - 3);	
		}
		
		// Check for overlap horizontally
		if playerRight < objectLeft or playerLeft > objectRight
		{
			return false;
		}
		
		// Check for overlap vertically
		else if playerBottom < objectTop or playerTop > objectBottom
		{
			return false;
		}
		
		// If player overlaps object on both axis, they collided with it
		else return true;
	}
	
	// Check for triggerbox overlap
	else if collisionType == CollisionTriggerbox
	{
		// Return collision result
		if variable_instance_exists(id, "objXRadiusTriggerLeft")
		{
			return point_in_rectangle(floor(Player.PosX), floor(Player.PosY), floor(x + objXRadiusTriggerLeft), floor(y + objYRadiusTriggerTop), floor(x + objXRadiusTriggerRight - 1), floor(y + objYRadiusTriggerBottom - 1));
		}	
	}
}