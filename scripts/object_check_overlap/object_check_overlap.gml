/// @function object_check_overlap(collisionType)
function object_check_overlap(collisionType)
{	
	// Exit if collision are disabled
	if !Player.AllowCollision
	{
		return false;
	}

	// Check for hitbox overlap
	if collisionType == Hitbox
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
		
		// Exit if object is off-screen
		var RX = sprite_get_width(sprite_index)  / 2;
		var RY = sprite_get_height(sprite_index) / 2;
		
		if x + RX < Camera.ViewX or x - RX > Camera.ViewX + Game.Width
		or y + RY < Camera.ViewY or y - RY > Camera.ViewY + Game.Height
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
	else if collisionType == Triggerbox
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