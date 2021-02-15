function PlayerCollideSolidObjects()
{	
	// Do not collide if we're not allowed to
	if !AllowCollision exit;
	
	// Player's position variables
	var PlayerX      = floor(PosX);
	var PlayerY		 = floor(PosY);
	var PlayerLeft   = floor(PosX - 10);
	var PlayerRight  = floor(PosX + 10);
	var PlayerTop    = floor(PosY - yRadius);
	var PlayerBottom = floor(PosY + yRadius);
	
	// ObjectID variables
	var	ObjectID   = collision_rectangle(PlayerLeft, PlayerTop, PlayerRight, PlayerBottom, Objects, true, true);
	var ReattachID = instance_position(PlayerX, PlayerBottom + 4, Objects);
	
	// Check for overlapping an object we're not standing on
	if variable_instance_exists(ObjectID, "Solidity")
	{	
		// Collide horizontally, but only if it is full solid object and we're on horizontal axis
		if ObjectID.Solidity = SolidAll and abs(ObjectID.x - PlayerX) > abs(ObjectID.y - PlayerY - 4)
		{
			// Collide on the left
			if PlayerX < ObjectID.x
			{
				if Xsp > 0
				{
					Xsp		= 0;
					Inertia = 0;
				}
				PosX -= PlayerRight - ObjectID.bbox_left + 1;
			}
			
			// Collide on the right
			else
			{
				if Xsp < 0
				{
					Xsp		= 0;
					Inertia = 0;
				}
				PosX += ObjectID.bbox_right - PlayerLeft + 1;
			}
		}

		// Collide vertically, but check if we're on vertical axis if object is full solid
		if !Grounded 
		{
			if ObjectID.Solidity = SolidAll and abs(ObjectID.x - PlayerX) <= abs(ObjectID.y - PlayerY - 4) 
			or ObjectID.Solidity = SolidTop
			{
				// Try to land on the object
				if PlayerY < ObjectID.y
				{
					if Ysp > 0 and ObjectID.bbox_top - PlayerBottom > -16
					{		
						Ysp		 = 0;
						Angle    = 0;
						Inertia  = Xsp;
						Grounded = true;	
						OnObject = ObjectID;
					}
				}
				
				// Collide from the bottom if it is full solid object
				else
				{
					if Ysp < 0 and ObjectID.Solidity = SolidAll
					{
						Ysp   = 0;
						PosY += ObjectID.bbox_bottom - floor(PosY - yRadius) + 1;
					}
				}
			}
		}
	}
	
	// Try to reattach to another object 4 pixels below us if grounded 
	if Grounded and variable_instance_exists(ReattachID, "Solidity")
	{
		if ReattachID.bbox_top - PlayerBottom > -16
		{
			OnObject = ReattachID;
		}
	}

	// Collide with an object we're currently standing on
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