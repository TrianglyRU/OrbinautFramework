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
	
	// Check for overlapping all objects with our inner hitbox
	var objNumb1 = collision_rectangle_list(InnerLeft, InnerTop, InnerRight, InnerBottom, Objects, false, true, objList1, false);
	if  objNumb1 > 0
	{ 
		for (var i = 0; i < objNumb1; ++i;)
		{ 
			var Obj = objList1[| i];
			
			// Check if collision has been set for the object we're colliding with
			if variable_instance_exists(Obj, "objCollisionType")
			{	
				// Tell the object we've collided with it
				Obj.objGotPlayerInHitbox = true;
			}
		} 
	} 
	
	// Check for overlapping all objects with our outer hitbox
	var objNumb2 = collision_rectangle_list(OuterLeft, OuterTop, OuterRight, OuterBottom, Objects, false, true, objList2, false);
	if  objNumb2 > 0
	{
		for (var k = 0; k < objNumb2; ++k;)
		{
			var solidObj = objList2[| k];
			
			// Check if collision has been set for the object we're colliding with
			if variable_instance_exists(solidObj, "objCollisionType")
			{	
				// Collide horizontally, but only if it is full solid object and we're on horizontal axis
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
				
				// Collide vertically, but check if we're on vertical axis if object is full solid		
				if solidObj.objCollisionType = SolidAll and abs(solidObj.x - PlayerX) <= abs(solidObj.y - PlayerY - 4) 
				or solidObj.objCollisionType = SolidTop
				{
					if !Grounded 
					{
						// Try to land on the object
						if PlayerY < solidObj.y
						{
							if Ysp > 0 and solidObj.bbox_top - OuterBottom > -16
							{	
								if  Game.ImprovedObjCollision 
								or !Game.ImprovedObjCollision and (PlayerX > solidObj.bbox_left and PlayerX < solidObj.bbox_right)
								{
									Inertia  = Xsp;
									Ysp		 = 0;
									Angle    = 0;
									Grounded = true;	
									OnObject = solidObj;
								}
							}
						}
				
						// Collide from the bottom if it is full solid object
						else
						{
							if Ysp < 0 and solidObj.objCollisionType = SolidAll
							{
								if (Flying) Grv = 0.03125;
								Ysp   = 0;
								PosY += solidObj.bbox_bottom - OuterTop + 1;
								
								// Tell object we're touching its bottom side
								solidObj.objGotPlayerOutHitboxBottom = true;			
								solidObj.objGotPlayerOutHitboxLeft   = false;			
								solidObj.objGotPlayerOutHitboxRight  = false;			
							}
						}
					}
					
					// Kill player if we collide with object's bottom while standing on another object
					else if OnObject
					{
						if solidObj.objCollisionType = SolidAll
						{
							if PlayerY > solidObj.y
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
	
	// Check for SolidTop and SolidAll objects 4 pixels below us while we're grounded using outer hitbox
	if Grounded
	{
		var objNumb3 = instance_position_list(PlayerX, OuterBottom + 4, Objects, objList3, false);
		if  objNumb3 > 0
		{
			for (var j = 0; j < objNumb3; ++j;)
			{
				var newSolidObj = objList3[| j];
				
				// Check if collision has been set for the object we're colliding with
				if variable_instance_exists(newSolidObj, "objCollisionType")
				{
					if newSolidObj.objCollisionType != SolidNone
					{
						// Attach to the object
						if newSolidObj.bbox_top - OuterBottom > -16
						{
							OnObject = newSolidObj;
						}
					}
				}
			}
		}
	}
	
	// Collide with solid object we're currently standing on using COLLISIONBOX
	if OnObject
	{	
		if instance_exists(OnObject)
		{
			// If we left its boundaries or it became non-solid, lose the object
			if OuterRight < OnObject.bbox_left or OuterLeft > OnObject.bbox_right or OnObject.objCollisionType = SolidNone
			{
				OnObject = false;
			}
			
			// Else attach to it
			else
			{
				PosY -= OuterBottom - OnObject.bbox_top + 1;	
				
				// Tell object we're touching its top side
				OnObject.objGotPlayerOutHitboxTop   = true;
				OnObject.objGotPlayerOutHitboxLeft  = false;
				OnObject.objGotPlayerOutHitboxRight = false;
			}
		}
		
		// Lose the object if it has been deleted or destroyed
		else
		{
			OnObject = false;
		}
	}
	
	// Reset object lists
	ds_list_destroy(objList1);			
	ds_list_destroy(objList2);
	ds_list_destroy(objList3);
}