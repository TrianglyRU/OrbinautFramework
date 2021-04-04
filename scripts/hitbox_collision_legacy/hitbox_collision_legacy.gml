/// @function hitbox_collision(collideFrom, collideWith)
function hitbox_collision_legacy(collideFrom, collideWith)
{	
	// Check for collision with player
	if collideFrom = Player
	{
		if variable_instance_exists(collideWith, "objCollisionType")
		{
			// Perform function only with non-solid objects
			if objCollisionType = SolidNone
			{
				// If player touched us already...
				if collideWith.objGotPlayerInHitbox
				{
					// ...then check if their hitbox still overlapping us
					var x1 = floor(Player.PosX - 8);
					var x2 = floor(Player.PosX + 8);			     
					var y1 = floor(Player.PosY - Player.yRadius + 3);
					var y2 = floor(Player.PosY + Player.yRadius - 3);
					
					collideWith.objGotPlayerInHitbox = collision_rectangle(x1, y1, x2, y2, collideWith, false, false);
					return collideWith.objGotPlayerInHitbox;
				}
				
				// Return false it we haven't collided with object yet
				else
				{
					return false;
				}
			}
			else
			{
				show_message("Instance ID " + string(id) + " collision type is not set to SolidNone (2). You can check for player's innter hitbox only with SolidNone collision type.");
				game_end();
			}
		}
		else
		{
			show_message("Instance ID " + string(collideWith.id) + " is not set as an object player can check for collision with using hitbox_collision function. Set collision type for the instance using 'object_set_collision' function.");
			game_end();
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