function PlayerObjectsInteraction()
{	
	// Do not collide if we're not allowed to
	if (AllowCollision == false) exit;
	
	// Get player's position
	var PlayerX = floor(PosX);
	var PlayerY	= floor(PosY);
	
	// Define player's outer hitbox size
	var OuterLeft   = floor(PosX - 10);
	var OuterRight  = floor(PosX + 10);
	var OuterTop    = floor(PosY - yRadius);
	var OuterBottom = floor(PosY + yRadius);
	
	// Define player's inner hitbox size
	var InnerLeft   = floor(PosX - 8);
	var InnerRight  = floor(PosX + 8);			     
	var InnerTop	= floor(PosY - yRadius + 3);
	var InnerBottom = floor(PosY + yRadius - 3);
	
	// Create object list
	var objList = ds_list_create();
	
	// Check for overlapping all objects with our inner hitbox
	var allObj_list = collision_rectangle_list(InnerLeft, InnerTop, InnerRight, InnerBottom, Objects, false, true, objList, false);
	if  allObj_list > 0
	{ 
		for (var i = 0; i < allObj_list; ++i;)
		{ 
			var allObj = objList[| i];
			
			// Check if object has collision
			if variable_instance_exists(allObj, "objCollisionType")
			{	
				// Tell the object we've collided with it
				allObj.objGotPlayerInHitbox = true;
			}
		} 
	} 
	ds_list_clear(objList);
	
	// Check for overlapping all non-slopey objects with our outer hitbox
	var solidObj_list = collision_rectangle_list(OuterLeft, OuterTop, OuterRight, OuterBottom, Objects, false, true, objList, false);
	if  solidObj_list > 0
	{
		for (var i = 0; i < solidObj_list; ++i;)
		{
			var solidObj = objList[| i];
			
			// Check if object has collision
			if variable_instance_exists(solidObj, "objCollisionType")
			{	
				// Collide horizontally with full solid objects
				if solidObj.objCollisionType == SolidAll and abs(solidObj.x - PlayerX) > abs(solidObj.y - PlayerY - 4)
				{
					// Collide on the left
					if PlayerX < solidObj.x
					{
						if Xsp > 0
						{
							Xsp		= 0;
							Inertia = 0;
						}
						PosX -= OuterRight - solidObj.bbox_left + 1;
						
						// Tell object we're touching its left side
						solidObj.objGotPlayerOutHitboxLeft = true;
					}
					
					// Collide on the right
					else
					{
						if Xsp < 0
						{
							Xsp		= 0;
							Inertia = 0;
						}
						PosX += solidObj.bbox_right - OuterLeft + 1;
						
						// Tell object we're touching its right side
						solidObj.objGotPlayerOutHitboxRight = true;
					}
				}
				
				// Collide vertically
				if solidObj.objCollisionType == SolidAll or solidObj.objCollisionType == SolidTop
				{
					if abs(solidObj.x - PlayerX) <= abs(solidObj.y - PlayerY - 4) 	
					{	
						if Grounded == false
						{	
							// Try to land on the object
							if PlayerY < solidObj.y
							{
								if Ysp > 0 and solidObj.bbox_top - OuterBottom > -16
								{	
									if Game.ImprovedObjCollision == true
									or Game.ImprovedObjCollision == false and (PlayerX > solidObj.bbox_left and PlayerX < solidObj.bbox_right)
									{
										Inertia  = Xsp;
										Ysp		 = 0;
										Grounded = true;	
										OnObject = solidObj;
									}
								}
							}
							
							// Collide with its bottom if we're below it
							else if solidObj.objCollisionType == SolidAll
							{
								if Ysp < 0
								{
									Ysp   = 0;
									PosY += solidObj.bbox_bottom - OuterTop + 1;
								
									// Tell object we're touching its bottom side
									solidObj.objGotPlayerOutHitboxBottom = true;			
									solidObj.objGotPlayerOutHitboxLeft   = false;			
									solidObj.objGotPlayerOutHitboxRight  = false;			
								}
							}
						}
						
						// If we're grounded, check for object to crush us
						else if solidObj.objCollisionType == SolidAll
						{
							if OuterTop < solidObj.bbox_bottom
							{
								Rings = 0;
								Hurt  = solidObj;			
							}
						}
					}					
				}
			}
		}
	}
	ds_list_clear(objList);
	
	// Check for overlapping slope-y objects with our bottom middle sensor
	var slopeObj_list = collision_point_list(PlayerX, OuterBottom, Objects, true, true, objList, false);
	if  slopeObj_list > 0
	{ 
		for (var i = 0; i < slopeObj_list; ++i;)
		{ 
			var slopeObj = objList[| i];
			
			// Check if object has collision
			if variable_instance_exists(slopeObj, "objCollisionType")
			{	
				// Collide
				if slopeObj.objCollisionType == SolidSlope and Ysp > 0
				{
					Inertia  = Xsp;
					Ysp		 = 0;
					Grounded = true;	
					OnObject = slopeObj;
				}
			}
		} 
	} 
	ds_list_clear(objList);
	
	// Check for overlapping all solid objects 4 pixels below us while we're grounded with our outer hitbox
	if Grounded == true
	{
		var newObj_list = collision_point_list(PlayerX, OuterBottom + 4, Objects, false, true, objList, false);
		if  newObj_list > 0
		{
			for (var i = 0; i < newObj_list; ++i;)
			{
				var newObj = objList[| i];
				
				// Check if object has collision
				if variable_instance_exists(newObj, "objCollisionType")
				{
					if newObj.objCollisionType != SolidNone
					{
						// Reatttach to the object
						if newObj.bbox_top - OuterBottom > -16
						{
							OnObject = newObj;
						}
					}
				}
			}
		}	
	}
	ds_list_clear(objList);
	
	// Collide with solid object we're currently standing on
	if OnObject
	{	
		// Tell object we're touching its top side
		OnObject.objGotPlayerOutHitboxTop   = true;
		OnObject.objGotPlayerOutHitboxLeft  = false;
		OnObject.objGotPlayerOutHitboxRight = false;
		
		// Force our angle to be 360
		Angle = 360;
	
		// Interact with non-slope objects
		if OnObject.objCollisionType != SolidSlope
		{
			// If we're outside of object's boundaries, lose it
			if OuterRight < OnObject.bbox_left or OuterLeft > OnObject.bbox_right or OnObject.objCollisionType = SolidNone
			{
				OnObject = false;
			}
			
			// Else attach to it
			else
			{
				PosY -= OuterBottom - OnObject.bbox_top + 1;
			}
		}
		
		// Interact with slope objects
		else
		{
			// Get default sensor position
			var ySensor = OuterBottom;
		
			// Adjust sensor y position using object's mask
			while not position_meeting(PlayerX, ySensor, OnObject) and ySensor < OuterBottom + 16
			{
				ySensor++;
			}
			while position_meeting(PlayerX, ySensor, OnObject)
			{
				ySensor--;
			}
				
			// Adjust player's position if we find object below the sensor, else lose it
			if position_meeting(PlayerX, ySensor + 1, OnObject)
			{
				PosY = ySensor - yRadius;
			}
			else
			{
				OnObject = false;
			}
		}
	}
	ds_list_destroy(objList);			
}