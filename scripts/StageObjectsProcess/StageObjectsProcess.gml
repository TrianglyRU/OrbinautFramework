function StageObjectsProcess() 
{	
	if DoUpdate
	{
		// Get active bounds
		var LeftBound  = (Camera.ViewX - 128) & -128;
		var RightBound = LeftBound + (((Game.Width + 128) & -128) + 256);
	
		with all 
		{	
			if variable_instance_exists(id, "Obj_UnloadStatus")
			{
				// Check if object is a parent
				var IsParent = variable_instance_exists(id, "Obj_ChildrenIDs");
				
				// If can't be unloaded, check if the object is within boundaries
				if !Obj_UnloadFlag
				{
					if x >= LeftBound and x <= RightBound
					{
						Obj_UnloadFlag = true;
					}
				}
				else switch Obj_UnloadStatus
				{
					// Destroy object
					case TypeDelete:
					{
						if x < LeftBound or x > RightBound or y > Stage.BottomBoundary
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
								
							// Perform create event to re-initialise variables
							event_perform(ev_create, 0);
						}
					}
					break;
				}
			}
		}
	}
	
	// Activate objects (object's that were unloaded this frame WON'T activate)
	instance_activate_range();
}