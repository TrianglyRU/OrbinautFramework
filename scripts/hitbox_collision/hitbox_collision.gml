/// @function hitbox_collision(collideFrom, collideWith)
function hitbox_collision(collideFrom, collideWith)
{	
	// Check if player collided with us
	if collideFrom = Player
	{
		return Player.GotObject = collideWith.id;
	}
	
	// Check if another object collided with us
	else
	{	
		// Get objects' hitbox
		var x1 = collideFrom.bbox_left;
		var x2 = collideFrom.bbox_right;
		var y1 = collideFrom.bbox_top;
		var y2 = collideFrom.bbox_bottom;
		
		// Return result
		return collision_rectangle(x1, y1, x2, y2, collideWith, false, false);
	}
}