function object_got_player(side)
{
	if variable_instance_exists(id, "objCollisionType")
	{	
		// Perform function only with solid objects
		if objCollisionType = SolidNone
		{
			show_message("Instance ID " + string(id) + " collision type is set to SolidNone (2). You can check for player's outer hitbox only with SolidAll (0) or SolidTop (1) collision types.");
			game_end();
		}
		else
		{
			with id
			{
				// If we collided with the object...
				if objGotPlayerOutHitboxTop   or objGotPlayerOutHitboxLeft 
				or objGotPlayerOutHitboxRight or objGotPlayerOutHitboxBottom
				{
					// ...then check if their outer hitbox still overlapping us
					var x1		 = floor(Player.PosX - 11);
					var x2		 = floor(Player.PosX + 11);			     
					var y1		 = floor(Player.PosY - Player.yRadius - 1);
					var y2		 = floor(Player.PosY + Player.yRadius + 1);
					var collided = collision_rectangle(x1, y1, x2, y2, id, false, false);
					
					// Return collision result
					if collided
					{					
						switch side
						{
							case SideTop:    return objGotPlayerOutHitboxTop;    break;
							case SideLeft:   return objGotPlayerOutHitboxLeft;   break;
							case SideRight:  return objGotPlayerOutHitboxRight;  break;
							case SideBottom: return objGotPlayerOutHitboxBottom; break;
						}
					}
					else
					{
						// Reset flags for the object if we're not colliding with it anymore
						objGotPlayerOutHitboxTop    = false;
						objGotPlayerOutHitboxLeft   = false;
						objGotPlayerOutHitboxRight  = false;
						objGotPlayerOutHitboxBottom = false;
						return false;
					}
				}
				
				// Return false it we haven't collided with object yet
				else
				{
					return false;
				}
			}		
		}
	}
	else
	{
		show_message("Instance ID " + string(id) + " is not set as an object player can check for collision with using object_got_player function. Set collision type for the instance using 'object_set_collision' function.");
		game_end();
	}
}