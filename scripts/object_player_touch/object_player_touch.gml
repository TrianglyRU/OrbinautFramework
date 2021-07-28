/// @function object_player_touch(collisionSide)
function object_player_touch(collisionSide)
{
	// Exit the code if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit the code if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		exit;
	}
	
	// Exit the code if object can't be collided
	if !objXRadiusSolid or !objYRadiusSolid
	{
		exit;	
	}
	
	// Get object
	var ObjectX		   = floor(x);
	var ObjectY        = floor(y);
	var ObjectRadiusX  = floor(objXRadiusSolid + 11);
	var ObjectRadiusY  = floor(objYRadiusSolid + Player.RadiusY);
	var ObjectID	   = id;

	// Get player
	var PlayerX = floor(Player.PosX);
	var PlayerY = floor(Player.PosY);
	
	// Return true if on object and checking for SideTop
	if collisionSide == SideTop and Player.OnObject == ObjectID 
	{	
		return true;
	}
			
	// If player is not standing on this object, collide with it
	else
	{	
		// Check for overlap
		var XDifference = PlayerX - ObjectX + ObjectRadiusX;
		if  XDifference < 0 or XDifference > ObjectRadiusX * 2
		{
			return false;
		}
		var YDifference = PlayerY - ObjectY + ObjectRadiusY + 4;
		if  YDifference < 0 or YDifference > ObjectRadiusY * 2
		{
			return false;
		}
		
		// Find collision direction
		var XDistance = PlayerX > ObjectX ? XDifference - ObjectRadiusX * 2 + 1 : XDifference;
		var YDistance = PlayerY > ObjectY ? YDifference - ObjectRadiusY * 2 - 4 : YDifference;
		
		// Check vertically
		if abs(XDistance) > abs(YDistance)
		{			
			// Check bottom
			if YDistance < 0 and collisionSide == SideBottom
			{
				return true;
			}
			
			// Check top
			else if YDistance < 16 and collisionSide == SideTop
			{
				var XComparison = PlayerX - ObjectX + objXRadiusSolid;			
				if  XComparison >= 0 or XComparison < objXRadiusSolid * 2
				{
					return Player.Ysp >= 0;
				}		
			}		
		}
		
		// Collide horizontally
		else if abs(YDistance) > 4
		{
			if XDistance > 0 and collisionSide == SideLeft
			or XDistance < 0 and collisionSide == SideRight
			{
				return true;
			}
		}
	}
	
	// If no collision happened, return
	return false;
}