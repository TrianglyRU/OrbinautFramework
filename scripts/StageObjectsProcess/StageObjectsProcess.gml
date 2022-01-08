function StageObjectsProcess() 
{	
	if DoUpdate
	{
		// Get active bounds
		var LeftBound  = (Camera.ViewX - 128) & -128;
		var RightBound = LeftBound + (((Game.Width + 128) & -128) + 256);
	
		with all 
		{	
			if variable_instance_exists(id, "Obj_UnloadType")
			{
				// Check if object is a parent
				var IsParent = variable_instance_exists(id, "Obj_ChildrenIDs");
				
				switch Obj_UnloadType
				{
					// Destroy object
					case TypeDelete:
					{
						if x < LeftBound or x > RightBound or y > Stage.BottomBoundary or y < Stage.TopBoundary
						{
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
					break;
					
					// Deactivate object
					case TypePause:
					{
						if x < LeftBound or x > RightBound
						{
							if IsParent
							{
								var Length = array_length(Obj_ChildrenIDs);
								for (var i = 0; i < Length; i++)
								{				
									instance_deactivate_object(Obj_ChildrenIDs[i]);
								}
								Obj_ChildrenIDs = [];
							}
							instance_deactivate_object(id);
						}
					}
					break;
					
					// Reset object
					case TypeReset:
					{
						if (x < LeftBound or x > RightBound) and (Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound)
						{
							if IsParent
							{
								var Length = array_length(Obj_ChildrenIDs);
								for (var i = 0; i < Length; i++)
								{
									instance_destroy(Obj_ChildrenIDs[i]);
								}
								Obj_ChildrenIDs = [];
							}
		
							// Reset data
							x			 = Obj_UnloadData[0];
							y			 = Obj_UnloadData[1];
							image_xscale = Obj_UnloadData[2];
							image_yscale = Obj_UnloadData[3];
							image_index  = Obj_UnloadData[4];
							sprite_index = Obj_UnloadData[5];
							visible      = Obj_UnloadData[6];
							
							// Reset animation data
							if variable_instance_exists(id, "image_duration")
							{
								image_duration = 0;
								image_timer    = 0;
							}
									
							// Perform create event to re-initialise variables
							event_perform(ev_create, 0);
							
							// Deactivate object
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
					break;
				}
			}
		}
	}
	
	// Activate objects (object's that were unloaded this frame WON'T activate)
	instance_activate_range(Camera.ViewX);
}