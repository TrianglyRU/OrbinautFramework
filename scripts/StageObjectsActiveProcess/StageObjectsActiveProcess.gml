function StageObjectsActiveProcess() 
{	
	// Script subfunction
	function StageObjectsActiveProcess_SubFunc(type)
	{
		if variable_instance_exists(id, "Obj_ChildrenIDs")
		{
			var Length = array_length(Obj_ChildrenIDs);
			for (var i = 0; i < Length; i++)
			{
				with Obj_ChildrenIDs[i]
				{
					if type
					{
						instance_destroy(id);
					}
					else
					{
						instance_deactivate_object(id);
					}
				}
			}
		}
		if type != 2
		{
			instance_deactivate_object(id);
		}
		else
		{
			instance_destroy();
		}
	}
	
	// If stage is active, unload objects that are off-screen
	if DoUpdate
	{
		with all if variable_instance_exists(id, "Obj_LoadStatus")
		{	
			// Get bounds
			var LeftBound   = Camera.ViewX - Obj_LoadX;
			var TopBound    = Camera.ViewY - Obj_LoadY;
			var RightBound  = Camera.ViewX + Game.Width  + Obj_LoadX;
			var BottomBound = Camera.ViewY + Game.Height + Obj_LoadY;
			
			// Check if the object is off-screen
			if x < LeftBound or x > RightBound
			or y < TopBound  or y > BottomBound
			{
				// Was object on the screen before?
				if Obj_LoadStatus
				{
					// Deactivate object and its children
					if Obj_LoadFlag == TypeUnload
					{
						StageObjectsActiveProcess_SubFunc(0);
					}
					else if Obj_LoadFlag == TypeReset
					{
						if Obj_LoadData[0] < LeftBound or Obj_LoadData[0] > RightBound
						{
							// Destroy children
							StageObjectsActiveProcess_SubFunc(1);
								
							// Reset object
							x			 = Obj_LoadData[0];
							y			 = Obj_LoadData[1];
							image_xscale = Obj_LoadData[2];
							image_yscale = Obj_LoadData[3];
								
							event_perform(ev_create,     0);
							event_perform(ev_room_start, 0);
						}
							
						// Deactivate object and its children
						StageObjectsActiveProcess_SubFunc(0);
					}
						
					// Destroy object and its children
					else if Obj_LoadFlag == ResetDelete
					{	
						StageObjectsActiveProcess_SubFunc(2);
					}
				}
					
				// Deactivate object and its children
				else
				{
					StageObjectsActiveProcess_SubFunc(0);
				}
			}
			
			// If object is inside the boundaries and has the reset flag, allow unload actions
			else if !Obj_LoadStatus
			{
				Obj_LoadStatus = true;		
			}
		}
	}
	
	// Activate unloaded objects inside of the largest region
	instance_activate_region(Camera.ViewX - 128, Camera.ViewY - 256, Game.Width + 256, Game.Height + 512, true);
}