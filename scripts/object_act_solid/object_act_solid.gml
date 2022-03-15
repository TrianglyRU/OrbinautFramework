/// @function object_act_solid(sides,top,bottom,resetActions)
function object_act_solid(sides,top,bottom,resetActions)
{
	/* The following is long and replicates the method of colliding with an object
	straight from the original games */
	
	// Clear flags
	Obj_SolidPush   = false;
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
	var ObjectX		    = x;
	var ObjectY         = y;
	var ObjectID	    = id;
	var ObjectMap		= Obj_SolidMap;
	var ObjectWidth     = Obj_SolidX;
	var ObjectHeight    = Obj_SolidY;
	var ObjectAddWidth  = Obj_SolidX + Player.RadiusW + 1;
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
		Player.PosX += ObjectX - xprevious;
		Player.PosY  = ObjectY - ObjectHeight - Player.RadiusY - 1 + SlopeOffset;
		
		var PlayerX = floor(Player.PosX);
		var PlayerY = floor(Player.PosY);
		
		var FallRadius = sides ? ObjectAddWidth : ObjectWidth;
		var XDiff      = PlayerX - ObjectX + FallRadius;
		
		// Lose the object if the player is outside its boundaries
		if XDiff < sides or XDiff > FallRadius * 2 - 1
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
	else
	{		
		// Check for overlap
		var XClip = PlayerX - ObjectX + ObjectAddWidth;
		var YClip = PlayerY - ObjectY + ObjectAddHeight - SlopeOffset + 4;
		
		if XClip < 0 or XClip > ObjectAddWidth * 2 - 1
		{
			return;
		}
		if YClip < 0 or YClip > ObjectAddHeight * 2 - 1
		{
			return;
		}
		
		var XDistance = PlayerX <= ObjectX ? XClip : XClip - ObjectAddWidth  * 2 + 1;
		var YDistance = PlayerY <= ObjectY ? YClip : YClip - ObjectAddHeight * 2 + 1;
		
		// Collide vertically
		if abs(XDistance) >= abs(YDistance)
		{	
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
						Player.PosY -= YDistance - 4;
						Player.Ysp   = 0;
					}
					
					// Tell the object it is being touched
					Obj_SolidTouchD = true;
				}
			}
			else if top and YDistance >= 0 and YDistance < 16
			{
				if PlayerY < ObjectY 
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
					}
				}
			}		
		}
		
		// Collide horizontally
		else if sides and abs(YDistance) > 4
		{	
			if XDistance != 0 and sign(XDistance) == sign(Player.Xsp)
			{
				if Player.Grounded
				{
					Obj_SolidPush  = true;
					Player.Pushing = true;
				}
				Player.Gsp     = 0;
				Player.Xsp	   = 0;
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