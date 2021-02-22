/// @function hitbox_collision(collideFrom, collideWith)
function hitbox_collision(collideFrom, collideWith)
{	
	// Check for collision with player
	if collideFrom = Player
	{
		if variable_instance_exists(collideWith, "GotPlayerHitbox")
		{	
			// If player collided us, check if their hitbox still overlapping us
			if collideWith.GotPlayerHitbox = true
			{
				var x1 = floor(collideFrom.PosX - 8);
				var x2 = floor(collideFrom.PosX + 8);			     
				var y1 = floor(collideFrom.PosY - collideFrom.yRadius + 3);
				var y2 = floor(collideFrom.PosY + collideFrom.yRadius - 3);
				
				return collision_rectangle(x1, y1, x2, y2, collideWith, false, false)
			}
		}
	}
	
	// Check for collision with another object
	else
	{
		var x1 = collideFrom.bbox_left;
		var x2 = collideFrom.bbox_right;
		var y1 = collideFrom.bbox_top;
		var y2 = collideFrom.bbox_bottom;

		return collision_rectangle(x1, y1, x2, y2, collideWith, false, true);
	}
}