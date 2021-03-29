function PlayerObjectsInteraction()
{	
	// Do not collide if we're not allowed to
	if !AllowCollision exit;
	
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
	
	// Create object lists
	var objList1 = ds_list_create();
	var objList2 = ds_list_create();
	var objList3 = ds_list_create();
	var objList4 = ds_list_create();
	
	// Check for overlapping all objects with our inner hitbox
	var objNumb1 = collision_rectangle_list(InnerLeft, InnerTop, InnerRight, InnerBottom, Objects, false, true, objList1, false);
	if  objNumb1 > 0
	{ 
		for (var i = 0; i < objNumb1; ++i;)
		{ 
			var Obj = objList1[| i];
			
			// Check if object has collision
			if variable_instance_exists(Obj, "objCollisionType")
			{	
				// Tell the object we've collided with it
				Obj.objGotPlayerInHitbox = true;
			}
		} 
	} 
	
	// Check for overlapping all non-slopey objects with our outer hitbox
	var objNumb2 = collision_rectangle_list(OuterLeft, OuterTop, OuterRight, OuterBottom, Objects, false, true, objList2, false);
	if  objNumb2 > 0
	{
		for (var i = 0; i < objNumb2; ++i;)
		{
			var solidObj = objList2[| i];
			
			// Check if object has collision
			if variable_instance_exists(solidObj, "objCollisionType")
			{	
				// Collide horizontally with full solid objects
				if solidObj.objCollisionType = SolidAll and abs(solidObj.x - PlayerX) > abs(solidObj.y - PlayerY - 4)
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
				if abs(solidObj.x - PlayerX) <= abs(solidObj.y - PlayerY - 4) 	
				{
					// Airborne collision
					if !Grounded 
					{
						// Try to land on the object
						if PlayerY < solidObj.y
						{
							if solidObj.objCollisionType = SolidAll or solidObj.objCollisionType = SolidTop
							{
								if Ysp > 0 and solidObj.bbox_top - OuterBottom > -16
								{	
									if  Game.ImprovedObjCollision 
									or !Game.ImprovedObjCollision and (PlayerX > solidObj.bbox_left and PlayerX < solidObj.bbox_right)
									{
										Inertia  = Xsp;
										Ysp		 = 0;
										Angle    = 360;
										Grounded = true;	
										OnObject = solidObj;
									}
								}
							}
						}
				
						// Collide from the bottom if object is full solid
						else
						{
							if Ysp < 0 and solidObj.objCollisionType = SolidAll
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
					
					// Ground collision
					else
					{
						// Kill player if we collide with object's bottom
						if solidObj.objCollisionType = SolidAll
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
	
	// Check for overlapping slope-y objects with our bottom middle sensor
	var objNumb3 = collision_point_list(PlayerX, OuterBottom, Objects, true, true, objList3, false);
	if  objNumb3 > 0
	{ 
		for (var i = 0; i < objNumb3; ++i;)
		{ 
			var slopeObj = objList3[| i];
			
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
	
	// Check for overlapping all solid objects 4 pixels below us while we're grounded with our outer hitbox
	if Grounded
	{
		var objNumb4 = collision_point_list(PlayerX, OuterBottom + 4, Objects, false, true, objList4, false);
		if  objNumb4 > 0
		{
			for (var i = 0; i < objNumb4; ++i;)
			{
				var newObj = objList4[| i];
				
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
			var slopeObjSensor = OuterBottom;
		
			// Adjust sensor y position using object's mask
			while !position_meeting(PlayerX, slopeObjSensor, OnObject) and slopeObjSensor < OuterBottom + 16
			{
				slopeObjSensor++;
			}
			while position_meeting(PlayerX, slopeObjSensor, OnObject)
			{
				slopeObjSensor--;
			}
				
			// Adjust player's position if we find object below the sensor, else lose it
			if position_meeting(PlayerX, slopeObjSensor + 1, OnObject)
			{
				PosY = slopeObjSensor - yRadius;
			}
			else
			{
				OnObject = false;
			}
		}
	}
	
	// Reset object lists
	ds_list_destroy(objList1);			
	ds_list_destroy(objList2);
	ds_list_destroy(objList3);
	ds_list_destroy(objList4);
}