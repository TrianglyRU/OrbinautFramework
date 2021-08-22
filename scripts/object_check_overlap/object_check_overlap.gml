/// @function object_check_overlap(collision_type)
function object_check_overlap(collision_type)
{	
	// Exit if collision are disabled
	if !Player.AllowCollision
	{
		return false;
	}
	
	// Check for hitbox overlap
	if collision_type == Hitbox
	{
		// Exit if this object hitbox wasn't initialized
		if !variable_instance_exists(id, "Obj_HitStatus")
		{
			return false;
		}
		
		// Exit if object can't be overlapped
		if !Obj_HitX or !Obj_HitY
		{
			return false;
		}
	
		// Get object's size
		var objectTop    = floor(y - Obj_HitY - 0);
		var objectLeft   = floor(x - Obj_HitX - 1);
		var objectRight  = floor(x + Obj_HitX - 1);
		var objectBottom = floor(y + Obj_HitY - 0);
		
		// Get player's hitbox
		if Player.Animation == AnimCrouch
		{
			var playerTop    = floor(Player.PosY - 4);
			var playerLeft   = floor(Player.PosX - 8);
			var playerRight  = floor(Player.PosX + 8);
			var playerBottom = floor(Player.PosY + 16);		
		}
		else
		{
			var playerTop    = floor(Player.PosY - Player.RadiusY + 3);
			var playerLeft   = floor(Player.PosX - 8);
			var playerRight  = floor(Player.PosX + 8);
			var playerBottom = floor(Player.PosY + Player.RadiusY - 3);	
		}
		
		// Check for overlap
		if playerRight < objectLeft or playerLeft > objectRight
		{
			return false;
		}
		else if playerBottom < objectTop or playerTop > objectBottom
		{
			return false;
		}
		
		// If player overlaps object on both axis, they collided with it
		return true;
	}
	
	// Check for triggerbox overlap
	else if collision_type == Triggerbox
	{
		// Exit if this object triggerbox wasn't initialized
		if !variable_instance_exists(id, "Obj_TriggerStatus")
		{
			return false;
		}
		
		// Return check result
		return point_in_rectangle(floor(Player.PosX), floor(Player.PosY), floor(x + Obj_TriggerLeft), floor(y + Obj_TriggerTop), floor(x + Obj_TriggerRight - 1), floor(y + Obj_TriggerBottom - 1));
	}
}