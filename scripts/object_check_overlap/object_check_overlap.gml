/// @function object_check_overlap(collision_type)
function object_check_overlap(collision_type)
{	
	// Exit if collision are disabled
	if !Player.AllowCollision
	{
		return false;
	}
	
	// Exit if object is off-screen
	if x < Camera.ViewX - 32 or x > Camera.ViewX + Game.Width  + 32
	or y < Camera.ViewY - 32 or y > Camera.ViewY + Game.Height + 32
	{
		exit;
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
		var ObjectTop    = floor(y - Obj_HitY - 0);
		var ObjectLeft   = floor(x - Obj_HitX - 0);
		var ObjectRight  = floor(x + Obj_HitX - 1);
		var ObjectBottom = floor(y + Obj_HitY - 1);
		
		// Get player's hitbox
		if Player.Animation == AnimCrouch
		{
			var PlayerTop    = floor(Player.PosY - 4);
			var PlayerLeft   = floor(Player.PosX - 8);
			var PlayerRight  = floor(Player.PosX + 8);
			var PlayerBottom = floor(Player.PosY + 16);		
		}
		else
		{
			var PlayerTop    = floor(Player.PosY - Player.RadiusY + 3);
			var PlayerLeft   = floor(Player.PosX - 8);
			var PlayerRight  = floor(Player.PosX + 8);
			var PlayerBottom = floor(Player.PosY + Player.RadiusY - 3);	
		}
		
		// Check for overlap
		if PlayerRight < ObjectLeft or PlayerLeft > ObjectRight
		{
			return false;
		}
		else if PlayerBottom < ObjectTop or PlayerTop > ObjectBottom
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