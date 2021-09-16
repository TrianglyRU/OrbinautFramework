function StageObjectsActiveProcess() 
{	
	// Exit if stage is inactive
	if !DoUpdate
	{
		exit;
	}
	
	// Get bounds
	var LeftBound  = Camera.ViewX div 256 * 256;
	var RightBound = Camera.ViewX div 256 * 256 + 768;
	
	with all if variable_instance_exists(id, "Obj_UnloadStatus")
	{	
		// Check if the object has children objects
		var IsParent = variable_instance_exists(id, "Obj_ChildrenIDs");
			
		// Get object's sprite width
		var SpriteWidth = sprite_get_width(sprite_index);
		
		// Check if the object should be deleted and is off-camera
		if Obj_UnloadStatus == TypeDelete
		{	
			if x + SpriteWidth < Camera.ViewX or x - SpriteWidth > Camera.ViewX + Game.Width
			{
				// Destroy object and its children
				if IsParent
				{
					var Length = array_length(Obj_ChildrenIDs);
					for (var i = 0; i < Length; i++)
					{				
						instance_destroy(Obj_ChildrenIDs[i]);
					}
					Obj_ChildrenIDs = [];
				}
				instance_destroy();
			}
		}	
		
		// Check if the object is outside of active boundaries
		else if x + SpriteWidth < LeftBound or x - SpriteWidth > RightBound 
		{
			// Was object on the screen before?
			if Obj_UnloadFlag
			{
				if Obj_UnloadStatus == TypePause
				{
					// Deactivate object and its children
					if IsParent
					{
						var Length = array_length(Obj_ChildrenIDs);
						for (var i = 0; i < Length; i++)
						{
							instance_deactivate_object(Obj_ChildrenIDs[i]);
						}
					}
					instance_deactivate_object(id);
				}
				else if Obj_UnloadStatus == TypeReset
				{	
					// Is initial position off-screen?
					if Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound
					{
						// Destroy children
						if IsParent
						{
							var Length = array_length(Obj_ChildrenIDs);
							for (var i = 0; i < Length; i++)
							{
								instance_destroy(Obj_ChildrenIDs[i]);
							}
							Obj_ChildrenIDs = [];
						}
								
						// Reset object
						x			 = Obj_UnloadData[0];
						y			 = Obj_UnloadData[1];
						image_xscale = Obj_UnloadData[2];
						image_yscale = Obj_UnloadData[3];
								
						// Perform create event to re-initialise variables
						event_perform(ev_create, 0);
					}
				}
			}
				
			// If not, pause object and its children
			else
			{
				if IsParent
				{
					var Length = array_length(Obj_ChildrenIDs);
					for (var i = 0; i < Length; i++)
					{
						instance_deactivate_object(Obj_ChildrenIDs[i]);
					}
				}
				instance_deactivate_object(id);
			}
		}
			
		// If object is inside the boundaries, allow unload
		else if !Obj_UnloadFlag
		{
			Obj_UnloadFlag = true;		
		}
	}
}