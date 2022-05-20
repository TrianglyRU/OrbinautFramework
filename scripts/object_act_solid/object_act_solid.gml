/// @function object_act_solid(sides,top,bottom,resetActions)
function object_act_solid(sides,top,bottom,resetActions)
{
	/* The following is long and replicates the method of colliding with an object
	straight from the original games closely enough */
	
	// Get solidity
	var SideCollision   = sides;
	var TopCollision    = top;
	var BottomCollision = bottom;
	
	// Clear flags
	Obj_SolidPush   = false;
	Obj_SolidTouchU = false;
	Obj_SolidTouchD	= false;
	Obj_SolidTouchL	= false;
	Obj_SolidTouchR	= false;
	
	// Exit if can't be collided
	if !Player.AllowCollision
	{
		return;
	}
	if !SideCollision and !TopCollision and !BottomCollision
	{
		return;
	}
	if !Obj_SolidX or !Obj_SolidY
	{
		return;	
	}
	if !object_is_onscreen(id)
	{
		return;
	}
	
	// Get object and player data
	var PlayerX         = floor(Player.PosX);
	var PlayerY         = floor(Player.PosY);
	var ObjectXLast		= xprevious;
	var ObjectX		    = x;
	var ObjectY         = y;
	var ObjectID	    = id;
	var ObjectMap		= Obj_SolidMap;
	var ObjectWidth     = Obj_SolidX;
	var ObjectHeight    = Obj_SolidY;
	var ObjectAddWidth  = Obj_SolidX + (Player.DefaultRadiusX + 1) + 1;
	var ObjectAddHeight = Obj_SolidY + Player.RadiusY + 1;
	
	// Calculate height difference
	if ObjectMap != false
	{
		if image_xscale
		{
			var Index = PlayerX - (ObjectX - ObjectWidth);
		}
		else
		{
			var Index = (ObjectX + ObjectWidth - 1) - PlayerX;
		}	
		Index = clamp(Index, 0, array_length(ObjectMap) - 1);
		
		var SlopeOffset = (ObjectHeight * 2 - ObjectMap[Index]) * image_yscale;	
	}
	else
	{
		var SlopeOffset = 0;
	}
	
	// Collide with the object
	if Player.OnObject == ObjectID
	{	
		// Move player
		Player.PosX += ObjectX - ObjectXLast;
		Player.PosY  = ObjectY - ObjectHeight + SlopeOffset - Player.RadiusY - 1;
		
		// Get new player position
		var PlayerX = floor(Player.PosX);
		var PlayerY = floor(Player.PosY);
		
		if SideCollision
		{
			var Width  = ObjectAddWidth;
			var XBound = 1;
		}
		else
		{
			var Width  = ObjectWidth;
			var XBound = 0;
		}
		var XDiff = PlayerX - ObjectX + Width;
		
		// Lose the object if player is outside its boundaries
		if XDiff < XBound or XDiff > Width * 2 - XBound - 1 
		{
			Player.OnObject = false;
		}
		
		// Tell the object it is being touched
		Obj_SolidTouchU = true;
	}
	else
	{		
		// If overlapping the object on both axis, continue
		var XClip = PlayerX - ObjectX + ObjectAddWidth;
		var YClip = PlayerY - ObjectY + ObjectAddHeight - SlopeOffset + 4;
		
		if  XClip >= 0 and XClip <= ObjectAddWidth  * 2 - 1
		and YClip >= 0 and YClip <= ObjectAddHeight * 2 - 1
		{
			// Get distances
			var XDistance = PlayerX <= ObjectX ? XClip : XClip - ObjectAddWidth  * 2 + 1;
			var YDistance = PlayerY <= ObjectY ? YClip : YClip - ObjectAddHeight * 2 + 1;
		
			// Collide vertically
			if abs(XDistance) >= abs(YDistance)
			{	
				// Collide from below
				if BottomCollision and PlayerY > ObjectY
				{
					if YDistance < 0
					{
						if Player.Grounded
						{
							if Player.Ysp == 0
							{
								player_damage(false, false, true);
							}
						}
						else if Player.Ysp < 0
						{
							Player.PosY -= YDistance - 4;
							Player.Ysp   = 0;
						}
					
						// Tell the object it is being touched
						Obj_SolidTouchD = true;
					}
				}
			
				// Collide from above
				if TopCollision and PlayerY <= ObjectY
				{
					if YDistance >= 0 and YDistance < 16
					{
						if Player.Ysp >= 0 and !Player.OnObject
						{
							// Continue only if player is within the object diameter
							var XDiff = PlayerX - ObjectX + ObjectWidth;
							if  XDiff < 0 or XDiff > ObjectWidth * 2 - 1
							{
								return;
							}
					
							// Land on the object
							with Player
							{
								PosY    -= YDistance - 4;
								OnObject = ObjectID;
								Gsp		 = Xsp;
								Ysp		 = 0;
								Angle    = 360;
							
								if resetActions
								{
									BarrierIsActive = false;
									DropdashRev		= -1;
								}
						
								// Call player script if airborne
								if !Grounded
								{
									Grounded = true; PlayerResetOnFloor();
								}
							}
						
							// Tell the object it is being touched
							Obj_SolidTouchU = true;
						}
					}
				}		
			}
		
			// Collide horizontally
			else if SideCollision
			{	
				if abs(YDistance) > 4
				{
					if XDistance != 0 and sign(XDistance) == sign(Player.Xsp)
					{
						if Player.Grounded
						{
							Obj_SolidPush  = true;
							Player.Pushing = true;
						}
						Player.Gsp = 0;
						Player.Xsp = 0;
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
	}
}