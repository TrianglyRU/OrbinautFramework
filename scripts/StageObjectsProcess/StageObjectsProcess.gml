function StageObjectsProcess() 
{	
	if UpdateObjects
	{
		/* Set active object bounds, accurate to the originals (if Width is set to 320px obviously, else adjusted). 
		If you decide to change that, also update instance_activate_range() */
		var AdjustBound = global.Width - 320;
		
		var LeftBound   = (Camera.ViewX & -128) - 128 - AdjustBound;
		var RightBound  = (Camera.ViewX & -128) + 640 + AdjustBound;
	
		with all 
		{	
			switch Obj_UnloadType
			{
				// Destroy object
				case FlagDelete:
				{
					if x < LeftBound or x > RightBound or y > Stage.BottomBoundary or y < Stage.TopBoundary
					{
						// Destroy object and its subobjects
						var Length = array_length(Obj_SubObjectIDs);
						if  Length
						{
							for (var i = 0; i < Length; i++)
							{				
								instance_destroy(Obj_SubObjectIDs[i]);
							}
							Obj_SubObjectIDs = [];
						}
						instance_destroy();
					}
				}
				break;
					
				// Deactivate object
				case FlagPause:
				{
					if x < LeftBound or x > RightBound
					{
						if Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound
						{
							// Deactivate object and its subobjects
							var Length = array_length(Obj_SubObjectIDs);
							if  Length
							{
								for (var i = 0; i < Length; i++)
								{				
									instance_deactivate_object(Obj_SubObjectIDs[i]);
								}
							}
							instance_deactivate_object(id);
						}
					}
				}
				break;
					
				// Reset object
				case FlagReset:
				{
					if x < LeftBound or x > RightBound
					{
						if Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound
						{
							var Length = array_length(Obj_SubObjectIDs);
							if  Length
							{
								for (var i = 0; i < Length; i++)
								{
									instance_destroy(Obj_SubObjectIDs[i]);
								}
								Obj_SubObjectIDs = [];
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
							
							// Deactivate object and its subobjects
							var Length = array_length(Obj_SubObjectIDs);
							if  Length
							{
								for (var i = 0; i < Length; i++)
								{
									instance_deactivate_object(Obj_SubObjectIDs[i]);
								}
							}
							instance_deactivate_object(id);
						}
					}
				}
				break;
			}
		}
	}
	
	// Load objects (objects that were deactivated on this frame won't activate!)
	instance_activate_range(Camera.ViewX);
}