function PlayerObjectsInteraction()
{	
	// Do not collide if we're not allowed to
	if !AllowCollision exit;
	
	// Get player's position
	var PlayerX      = floor(PosX);
	var PlayerY		 = floor(PosY);
	
	// Define player's solid objects collision mask
	var PlayerLeft   = floor(PosX - 10);
	var PlayerRight  = floor(PosX + 10);
	var PlayerTop    = floor(PosY - yRadius);
	var PlayerBottom = floor(PosY + yRadius);
	
	// Define player's hitbox size
	var HitboxLeft   = floor(PosX - 8);
	var HitboxRight  = floor(PosX + 8);			     
	var HitboxTop	 = floor(PosY - yRadius + 3);
	var HitboxBottom = floor(PosY + yRadius - 3);
	
	// Check for overlapping all objects with our hitbox
	var objList = ds_list_create();
	var objNumb = collision_rectangle_list(HitboxLeft, HitboxTop, HitboxRight, HitboxBottom, Objects, false, true, objList, false);
	if  objNumb > 0
	{ 
		for (var i = 0; i < objNumb; ++i;)
		{ 
			GotObject = objList[| i];
			if variable_instance_exists(GotObject, "GotPlayerHitbox")
			{
				GotObject.GotPlayerHitbox = true;
			}
		} 
	} 
	else
	{
		GotObject = false;
	}
	ds_list_destroy(objList);
	
	// Check for colliding solid object we're not standing on
	var solidObj = collision_rectangle(PlayerLeft, PlayerTop, PlayerRight, PlayerBottom, Objects, true, true);
	if variable_instance_exists(solidObj, "Solidity")
	{	
		// Collide horizontally, but only if it is full solid object and we're on horizontal axis
		if solidObj.Solidity = SolidAll and abs(solidObj.x - PlayerX) > abs(solidObj.y - PlayerY - 4)
		{
			// Collide on the left
			if PlayerX < solidObj.x
			{
				if Xsp > 0
				{
					Xsp		= 0;
					Inertia = 0;
				}
				PosX -= PlayerRight - solidObj.bbox_left + 1;
			}
			
			// Collide on the right
			else
			{
				if Xsp < 0
				{
					Xsp		= 0;
					Inertia = 0;
				}
				PosX += solidObj.bbox_right - PlayerLeft + 1;
			}
		}

		// Collide vertically, but check if we're on vertical axis if object is full solid
		if !Grounded 
		{
			if solidObj.Solidity = SolidAll and abs(solidObj.x - PlayerX) <= abs(solidObj.y - PlayerY - 4) 
			or solidObj.Solidity = SolidTop
			{
				// Try to land on the object
				if PlayerY < solidObj.y
				{
					if Ysp > 0 and solidObj.bbox_top - PlayerBottom > -16
					{	
						if  Game.ImprovedObjCollision 
						or !Game.ImprovedObjCollision and (PlayerX > solidObj.bbox_left and PlayerX < solidObj.bbox_right)
						{
							Ysp		 = 0;
							Angle    = 0;
							Inertia  = Xsp;
							Grounded = true;	
							OnObject = solidObj;
						}
					}
				}
				
				// Collide from the bottom if it is full solid object
				else
				{
					if Ysp < 0 and solidObj.Solidity = SolidAll
					{
						Ysp   = 0;
						PosY += solidObj.bbox_bottom - PlayerTop + 1;
					}
				}
			}
		}
	}
	
	// Try to reattach to another solid object 4 pixels below us if grounded 
	var newSolidObj = instance_position(PlayerX, PlayerBottom + 4, Objects);
	if Grounded and variable_instance_exists(newSolidObj, "Solidity")
	{
		if newSolidObj.bbox_top - PlayerBottom > -16
		{
			OnObject = newSolidObj;
		}
	}

	// Collide with solid object we're currently standing on
	if OnObject
	{	
		if PlayerRight < OnObject.bbox_left or PlayerLeft > OnObject.bbox_right
		{
			OnObject = false;
		}
		else
		{
			PosY -= PlayerBottom - OnObject.bbox_top + 1;	
		}
	}
}