/// @function object_player_touch(collisionSide)
function object_player_touch(collisionSide)
{
	// Exit the code if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit the code if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "Obj_SolidStatus")
	{
		exit;
	}
	
	// Exit the code if object can't be collided
	if !Obj_SolidX or !Obj_SolidY
	{
		exit;	
	}
	
	// Get object
	var ObjectX		   = floor(x);
	var ObjectY        = floor(y);
	var ObjectRadiusX  = floor(Obj_SolidX + 11);
	var ObjectRadiusY  = floor(Obj_SolidY + Player.RadiusY);
	var ObjectID	   = id;

	// Get player
	var PlayerX = floor(Player.PosX);
	var PlayerY = floor(Player.PosY);
	
	// Get height array
	if Obj_SolidMap != false
	{
		// Get object sides
		var ObjectLeft  = floor(x - Obj_SolidX - 0);
		var ObjectRight = floor(x + Obj_SolidX - 1);
			
		// Get height from array to use
		var ArrayHeight = clamp(image_xscale ? PlayerX - ObjectLeft : ObjectRight - PlayerX, 0, array_length(Obj_SolidMap) - 1);
		
		// Calculate height difference
		var ObjectHeight = (Obj_SolidY * 2 - Obj_SolidMap[ArrayHeight]) * image_yscale;	
	}
	else
	{
		var ObjectHeight = 0;
	}
	
	if Player.OnObject == ObjectID
	{			
		return collisionSide == SideTop;
	}
	else
	{	
		// Check for overlap
		var XDifference = PlayerX - ObjectX + ObjectRadiusX;
		if  XDifference < 0 or XDifference > ObjectRadiusX * 2
		{
			return false;
		}		
		var YDifference = PlayerY - ObjectY + ObjectRadiusY + 4 - ObjectHeight;
		if  YDifference < 0 or YDifference > ObjectRadiusY * 2
		{
			return false;
		}
		
		// Find collision direction
		var XDistance = PlayerX > ObjectX ? XDifference - ObjectRadiusX * 2     : XDifference;
		var YDistance = PlayerY > ObjectY ? YDifference - ObjectRadiusY * 2 - 4 : YDifference;
		
		// Collide vertically
		if abs(XDistance) > abs(YDistance)
		{			
			// Collide bottom
			if YDistance < 0 and Player.Ysp < 0
			{	
				return collisionSide == SideBottom;
			}
			
			// Collide top
			else if YDistance > 0 and YDistance < 16 and Player.Ysp >= 0
			{
				// Exit if outside the object
				var XComparison = PlayerX - ObjectX + Obj_SolidX;
				if  XComparison < 0 or XComparison >= Obj_SolidX * 2
				{
					exit;
				}
				
				return collisionSide == SideTop;
			}		
		}
		
		// Collide horizontally
		else if abs(YDistance) > 4
		{
			// Stop
			if XDistance > 0 and Player.Xsp > 0
			{
				return collisionSide == SideLeft;
			}
			else if XDistance < 0 and Player.Xsp < 0
			{
				return collisionSide == SideRight;
			}
		}
	}
}