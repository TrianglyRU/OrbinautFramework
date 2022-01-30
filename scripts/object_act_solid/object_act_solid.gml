/// @function object_act_solid(sides,top,bottom,resetActions)
function object_act_solid(sides,top,bottom,resetActions)
{
	/* The following is long and replicates the original method of colliding with an object, 
	however, it was tweaked in several places to make collision much more consistent */
	
	// Clear flags
	Obj_SolidPush   = false;
	Obj_SolidTouchU	= false;
	Obj_SolidTouchD	= false;
	Obj_SolidTouchL	= false;
	Obj_SolidTouchR	= false;
	
	// Exit if can't be collided
	if !Player.AllowCollision
	{
		return false;
	}
	if !sides and !top and !bottom
	{
		return false;
	}
	if !Obj_SolidX or !Obj_SolidY
	{
		return false;	
	}
	if !object_is_onscreen(id)
	{
		return false;
	}
	
	// Get object and player data
	var PlayerX         = floor(Player.PosX);
	var PlayerY         = floor(Player.PosY);
	var ObjectID	    = id;
	var ObjectX		    = x;
	var ObjectY         = y;
	var ObjectAddWidth  = Obj_SolidX + Player.RadiusW + 1;
	var ObjectAddHeight = Obj_SolidY + Player.RadiusY + 1;
	
	// Get height array
	if Obj_SolidMap != false
	{
		if image_xscale
		{
			var ArrayHeight = PlayerX - (x - Obj_SolidX);
		}
		else
		{
			var ArrayHeight = (x + Obj_SolidX - 1) - PlayerX;
		}	
		ArrayHeight = clamp(ArrayHeight, 0, array_length(Obj_SolidMap) - 1);
		
		// Calculate height difference
		var SlopeOffset = (Obj_SolidY * 2 - Obj_SolidMap[ArrayHeight]) * image_yscale;	
	}
	else
	{
		var SlopeOffset = 0;
	}
	
	// Attach to the object
	if Player.OnObject == ObjectID
	{	
		Obj_SolidTouchU = true;
		
		Player.PosX += floor(x - xprevious);
		Player.PosY  = ObjectY - Obj_SolidY - Player.RadiusY + SlopeOffset - 1;
		
		// Lose the object if the player is outside its boundaries
		var FallRadius = sides ? ObjectAddWidth : Obj_SolidX + 1;
		
		var XDiff  = floor(Player.PosX) - ObjectX + FallRadius;
		if  XDiff <= 0 or XDiff >= FallRadius * 2 - 1
		{
			var ThisObject = object_index;
			with Player
			{
				if Animation == AnimMove and ThisObject != Bridge
				{
					animation_reset(0);
				}
				OnObject = false;
			}
		}
	}
	
	// Collide with the object
	else
	{		
		var VGrip = 4; // <- This allows us to grip to the object even if we're 4 pixels above it
		
		// Check for overlap
		var XClip = PlayerX - ObjectX + ObjectAddWidth;
		if  XClip < 0 or XClip > ObjectAddWidth * 2 - 1
		{
			return;
		}
		var YClip = PlayerY - ObjectY - SlopeOffset + ObjectAddHeight + VGrip;
		if  YClip < 0 or YClip > ObjectAddHeight * 2 + VGrip - 1
		{
			return;
		}
		var XDistance = PlayerX > ObjectX ? XClip - ObjectAddWidth  * 2 + 1			: XClip;
		var YDistance = PlayerY > ObjectY ? YClip - ObjectAddHeight * 2 - VGrip + 1 : YClip;
		
		// Collide vertically
		if abs(XDistance) >= abs(YDistance)
		{	
			// Collide from below
			if bottom and YDistance < 0
			{
				if PlayerY > ObjectY
				{
					if Player.Grounded
					{
						if abs(XDistance) >= 16 and Player.Ysp == 0
						{
							player_damage(false, false, true);
						}
					}
					else if Player.Ysp < 0
					{
						if Player.FlightState
						{
							Player.Grv = 0.03125;
						}
						Player.PosY -= YDistance;
						Player.Ysp   = 0;
					}
					Obj_SolidTouchD = true;
				}
			}
			
			// Collide from above
			else if top and YDistance >= 0 and YDistance < 16
			{
				if PlayerY < ObjectY and Player.Ysp >= 0 and !Player.OnObject
				{
					// Exit if the player is outside object's boundaries
					var LandRadius = sides ? ObjectAddWidth : Obj_SolidX + 1;
					
					var XDiff  = PlayerX - ObjectX + LandRadius;
					if  XDiff <= 0 or XDiff >= LandRadius * 2 - 1
					{
						return;
					}
					
					// Land on the object
					with Player
					{
						if resetActions
						{
							BarrierIsActive = false;
							DropdashRev		= -1;
						}
						PosY    -= YDistance - 4;
						OnObject = ObjectID;
						Inertia  = Xsp;
						Angle    = 360;
						Grounded = true;
						
						// Call player script
						PlayerResetOnFloor();
					}
					Obj_SolidTouchU = true;
				}
			}		
		}
		
		// Collide horizontally
		else if sides and abs(YDistance) > 4
		{	
			if XDistance != 0 and sign(XDistance) == sign(Player.Xsp)
			{
				Player.Inertia = 0;
				Player.Xsp	   = 0;					
				Player.Pushing = true;
				Obj_SolidPush  = true;
			}
			Player.PosX -= XDistance;
			
			// Tell the object it is being touched
			if PlayerX < ObjectX
			{
				Obj_SolidTouchL = true;
			}
			else
			{
				Obj_SolidTouchR = true;
			}	
		}
	}
}