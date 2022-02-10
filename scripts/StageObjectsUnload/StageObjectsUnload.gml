function StageObjectsUnload() 
{	
	if UpdateObjects
	{
		// Get active bounds
		var LeftBound  = (Camera.ViewX - 128) & -128;
		var RightBound = LeftBound + (((400 + 128) & -128) + 256);
	
		with all 
		{	
			{
				switch Obj_UnloadType
				{
					// Destroy object
					case TypeDelete:
					{
						if x < LeftBound or x > RightBound or y > Stage.BottomBoundary or y < Stage.TopBoundary
						{
							var Length = array_length(Obj_ChildrenIDs);
							if  Length
							{
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
							var Length = array_length(Obj_ChildrenIDs);
							if  Length
							{
								for (var i = 0; i < Length; i++)
								{				
									instance_destroy(Obj_ChildrenIDs[i]);
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
							var Length = array_length(Obj_ChildrenIDs);
							if  Length
							{
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
							Obj_AnimDuration = 0;
							Obj_AnimTimer    = 0;
									
							// Perform create event to re-initialise variables
							event_perform(ev_create, 0);
							
							// Deactivate object
							var Length = array_length(Obj_ChildrenIDs);
							if  Length
							{
								for (var i = 0; i < Length; i++)
								{
									instance_deactivate_object(Obj_ChildrenIDs[i]);
								}
							}
							instance_deactivate_object(id);
						}
					}
					break;
					default: break;
				}
			}
		}
	}
	
	// Load objects (objects that were deactivated this frame won't activate!)
	instance_activate_range(Camera.ViewX);
}