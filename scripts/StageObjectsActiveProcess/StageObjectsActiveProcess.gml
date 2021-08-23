function StageObjectsActiveProcess() 
{	
	// If stage is active, unload objects that are off-screen
	if DoUpdate
	{
		with all if variable_instance_exists(id, "Obj_LoadStatus")
		{	
			// Check if the object has children objects
			var IsParent = variable_instance_exists(id, "Obj_ChildrenIDs");
			
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
					if Obj_LoadFlag != false
					{
						// Deactivate object and its children
						if Obj_LoadFlag == TypeUnload
						{
							if IsParent
							{
								var Length = array_length(Obj_ChildrenIDs);
								for (var i = 0; i < Length; i++)
								{
									with Obj_ChildrenIDs[i]
									{
										instance_deactivate_object(id);
									}
								}
							}
							instance_deactivate_object(id);
						}
						else if Obj_LoadFlag == TypeReset
						{	
							if object_index == Orbinaut
							{
								show_debug_message(string(random(225)) + " kek");
							}
							
							if Obj_LoadData[0] < LeftBound or Obj_LoadData[0] > RightBound
							{
								show_debug_message("A)");
								
								// Destroy children
								if IsParent
								{
									var Length = array_length(Obj_ChildrenIDs);
									for (var i = 0; i < Length; i++)
									{
										with Obj_ChildrenIDs[i]
										{
											instance_destroy();
										}
									}
								}
								
								// Reset object
								x			 = Obj_LoadData[0];
								y			 = Obj_LoadData[1];
								image_xscale = Obj_LoadData[2];
								image_yscale = Obj_LoadData[3];
							
								event_perform(ev_create,     0);
								event_perform(ev_room_start, 0);
							}
							else
							{
								// Deactivate object and its children
								if IsParent
								{
									var Length = array_length(Obj_ChildrenIDs);
									for (var i = 0; i < Length; i++)
									{
										with Obj_ChildrenIDs[i]
										{
											instance_deactivate_object(id);
										}
									}
								}
								instance_deactivate_object(id);
							}
						}
						
						// Destroy object and its children
						else if Obj_LoadFlag == TypeDelete
						{	
							if IsParent
							{
								var Length = array_length(Obj_ChildrenIDs);
								for (var i = 0; i < Length; i++)
								{
									with Obj_ChildrenIDs[i]
									{
										instance_destroy();
									}
								}
							}
							instance_destroy();
						}
					}
				}
					
				// Deactivate object and its children
				else
				{
					if IsParent
					{
						var Length = array_length(Obj_ChildrenIDs);
						for (var i = 0; i < Length; i++)
						{
							with Obj_ChildrenIDs[i]
							{
								instance_deactivate_object(id);
							}
						}
					}
					instance_deactivate_object(id);
				}
			}
			
			// If object is inside the boundaries, allow unload
			else if !Obj_LoadStatus
			{
				Obj_LoadStatus = true;		
			}
		}
	}
	
	// Activate unloaded objects inside of the largest region
	instance_activate_region(Camera.ViewX - 128, Camera.ViewY - 256, Game.Width + 256, Game.Height + 512, true);
}