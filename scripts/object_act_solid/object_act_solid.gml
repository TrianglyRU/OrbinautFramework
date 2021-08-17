/// @function object_act_solid(sides, top, bottom)
function object_act_solid(sides, top, bottom)
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
	
	// Exit the code if there is no side to collide with 
	if !sides and !top and !bottom
	{
		if Player.OnObject == id
		{
			Player.OnObject = false;
			Player.Grounded = false;
		}
		exit;
	}
	
	// Clear touch flags
	Obj_SolidTouchU	= false;
	Obj_SolidTouchD	= false;
	Obj_SolidTouchL	= false;
	Obj_SolidTouchR	= false;
	
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
	
	// Check if player is standing on this object, collide only with its top side
	if Player.OnObject == ObjectID
	{	
		// Make player to follow horizonatal movement of the object
		Player.PosX += floor(x - xprevious);
		
		// Make player to always stay on top of the object
		Player.PosY = ObjectY - Obj_SolidY - Player.RadiusY + ObjectHeight - 1;
			
		// Tell the object we're touching its top side
		Obj_SolidTouchU = true;
		
		// Get fall radius
		var FallRadius = sides ? ObjectRadiusX : Obj_SolidX;
		
		// Check if player is outside the object
		var XComparison = floor(Player.PosX) - ObjectX + FallRadius;
		if  XComparison < 0 or XComparison >= FallRadius * 2
		{
			Player.OnObject = false;
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
		var YDifference = PlayerY - ObjectY + ObjectRadiusY + 4 - ObjectHeight;
		if  YDifference < 0 or YDifference > ObjectRadiusY * 2
		{
			exit;
		}
		
		// Find collision direction
		var XDistance = PlayerX > ObjectX ? XDifference - ObjectRadiusX * 2     : XDifference;
		var YDistance = PlayerY > ObjectY ? YDifference - ObjectRadiusY * 2 - 4 : YDifference;
		
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
				if Player.FlightState
				{
					Player.Grv = 0.03125;
				}
				
				// Tell the object we're touching its top side
				Obj_SolidTouchD = true;
				
				/* In S1 and S2 the game would also kill you if you were grounded, 
				   however that was changed in S3 to allow to you use springs on ceilings */
			}
			
			// Collide top
			else if top and YDistance > 0 and YDistance < 16 and Player.Ysp >= 0
			{
				// Get land radius
				var LandRadius  = sides ? ObjectRadiusX : Obj_SolidX;
		
				// Exit if outside the object
				var XComparison = PlayerX - ObjectX + LandRadius;
				if  XComparison < 0 or XComparison >= LandRadius * 2
				{
					exit;
				}
				
				// Tell the object we're touching its top side
				Obj_SolidTouchU = true;
				
				// Do from player's side
				with Player
				{
					// Attach player to the object's top boundary
					PosY -= YDistance - 3;
					
					// Become grounded
					Grounded = true;
					OnObject = ObjectID;
					
					// Update horizontal speed and angle
					Inertia  = Xsp;
					Angle    = 360;
					
					/* We normally don't call *scripts* inside scripts or functions
					in Orbinaut, but that's really the case where we need to do this */
					PlayerResetOnFloor();
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
				// Tell the object we're touching its side
				if Player.Xsp > 0
				{
					Obj_SolidTouchL = true;
				}
				else if Player.Xsp < 0
				{
					Obj_SolidTouchR = true;
				}
				
				// Reset speeds
				if Player.Grounded
				{
					Player.Inertia = 0;
				}
				Player.Xsp = 0;
				
				// Set pushing flag
				Player.Pushing = true;
			}
			
			// Push outside
			Player.PosX -= XDistance;
		}
	}
}