/// @function object_act_solid(sides, top, bottom, height_array)
function object_act_solid(sides, top, bottom, height_array)
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
	
	// Exit the code if there is no side to collide with 
	if !sides and !top and !bottom
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
	
	// Get height array
	if height_array != false
	{
		// Get object sides
		var ObjectLeft  = floor(x - objXRadiusSolid - 0);
		var ObjectRight = floor(x + objXRadiusSolid - 1);
			
		// Get height from array to use
		var ArrayHeight = clamp(image_xscale ? PlayerX - ObjectLeft : ObjectRight - PlayerX, 0, array_length(height_array) - 1);
		
		// Calculate height difference
		var ObjectHeight = (objYRadiusSolid * 2 - height_array[ArrayHeight]) * image_yscale;	
	}
	else
	{
		var ObjectHeight = 0;
	}
	
	// Check if player is standing on this object, collide only with its top side
	if Player.OnObject == ObjectID
	{	
		// Get fall radius
		var FallRadius = sides ? ObjectRadiusX : objXRadiusSolid;
		
		// Check if player is outside the object
		var XComparison = PlayerX - ObjectX + FallRadius;
		if  XComparison < 0 or XComparison >= FallRadius * 2
		{
			Player.OnObject = false;
		}
		else
		{	
			// Make player to follow horizonatal movement of the object
			Player.PosX += floor(x - xprevious);
							
			// Make player to always stay on top of the object
			Player.PosY = ObjectY - objYRadiusSolid - Player.RadiusY + ObjectHeight - 1;
		}
	}
			
	// If player is not standing on this object, collide with it
	else
	{	
		// Check for overlap
		var XDifference = PlayerX - ObjectX + ObjectRadiusX;
		if  XDifference < 0 or XDifference > ObjectRadiusX * 2
		{
			exit;
		}		
		var YDifference = PlayerY - ObjectY + ObjectRadiusY + !sides * 4 - ObjectHeight;
		if  YDifference < 0 or YDifference > ObjectRadiusY * 2
		{
			exit;
		}
		
		// Find collision direction
		var XDistance = PlayerX > ObjectX ? XDifference - ObjectRadiusX * 2 + 1          : XDifference;
		var YDistance = PlayerY > ObjectY ? YDifference - ObjectRadiusY * 2 - !sides * 4 : YDifference;
		
		// Collide vertically
		if abs(XDistance) > abs(YDistance)
		{			
			// Collide bottom
			if bottom and YDistance < 0 and Player.Ysp < 0
			{	
				// Clip out
				Player.PosY -= YDistance;
				Player.Ysp   = 0;
				
				// Reset gravity if flying
				if FlightState
				{
					Grv	= 0.03125;
				}	
				
				/* In S1 and S2 the game would also kill you if you were grounded, 
				   however that was changed in S3 to allow to you use springs on ceilings */
			}
			
			// Collide top
			else if top and YDistance > 0 and YDistance < 16 and Player.Ysp >= 0
			{
				// Get land radius
				var LandRadius  = sides ? ObjectRadiusX : objXRadiusSolid;
		
				// Exit if outside the object
				var XComparison = PlayerX - ObjectX + LandRadius;
				if  XComparison < 0 or XComparison >= LandRadius * 2
				{
					exit;
				}
				
				// Do from player's side
				with Player
				{
					// Attach player to the object's top boundary
					if !(Grounded and sides)
					{
						YDistance -= 4;
					}
					PosY -= YDistance + 1
					
					// Become grounded
					Grounded = true;
					OnObject = ObjectID;
					
					// Update horizontal speed and angle
					Inertia  = Xsp;
					Angle    = 360;
					
					/* We normally don't call *scripts* inside scripts or functions
					in Orbinaut, but that's really the case where we need to do this */
					PlayerResetOnFloor();
					
					// Reset vertical speed
					Ysp = 0;
				}
			}		
		}
		
		// Collide horizontally
		else if sides and abs(YDistance) > 4
		{
			// Stop
			if XDistance > 0 and Player.Xsp > 0
			or XDistance < 0 and Player.Xsp < 0
			{
				if Player.Grounded
				{
					Player.Inertia = 0;
				}
				Player.Xsp = 0;
			}
			
			// Push outside
			Player.PosX -= XDistance;
		}
	}
}