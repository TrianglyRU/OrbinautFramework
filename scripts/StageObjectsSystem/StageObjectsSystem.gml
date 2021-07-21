function StageObjectsSystem()
{
	/* Originals load and unload objects within specific rounded ranges.
	We'll use Retro Engine boundaries instead, as it will result in better performance */
	
	if Player.Death
	{
		exit;
	}
	
	with all
	{	
		// Check if object was unloaded to reset its state
		if object_index == BlankObject
		{
			// Get initial data
			var InitialX      = InitialData[0];
			var InitialY	  = InitialData[1];
			var InitialXScale = InitialData[2];
			var InitialYScale = InitialData[3];
			
			// Respawn object if its initial position if off-limits
			if InitialX < Screen.CameraX - InitialRange or InitialX > Screen.CameraX + Screen.Width + InitialRange
			{
				var  RestoredObj = instance_create(InitialX, InitialY, InitialObject);
				with RestoredObj
				{
					image_xscale = InitialXScale;
					image_yscale = InitialYScale;
					
					event_perform(ev_create,     0);
					event_perform(ev_room_start, 0);
				}
				instance_destroy(id);
			}		
		}
		
		// Check if object can be unloaded
		else if variable_instance_exists(id, "objResetFlag")
		{	
			// Get position
			var ObjectX = floor(x);
			var ObjectY = floor(y);
			
			// Get limits
			var LeftBound   = Screen.CameraX - objLoadRangeX;
			var TopBound    = Screen.CameraY - objLoadRangeY;
			var RightBound  = Screen.CameraX + Screen.Width  + objLoadRangeX;
			var BottomBound = Screen.CameraY + Screen.Height + objLoadRangeY;
			
			// Check if the object is off-limits
			if ObjectX < LeftBound or ObjectX > RightBound
			or ObjectY < TopBound  or ObjectY > BottomBound
			{
				// Is reset flag set?
				if objResetFlag
				{
					// Was object on the screen before?
					if variable_instance_exists(id, "objResetActive")
					{
						// Should object be resetted to its initial state?
						if objResetFlag == 1
						{
							// Remember the object
							/*var ThisObj = object_index;
							var ThisID  = id;
					
							// Create a blank object on its place and save object data to it
							var  NewObj = instance_create(ObjectX, ObjectY, BlankObject);
							with NewObj
							{
								InitialObject = ThisObj;
								InitialRange  = ThisID.objLoadRangeX;
								InitialData   = ThisID.objResetData;
							}*/
							
							// Respawn object if its initial position if off-limits
							if objResetData[0] < Screen.CameraX - objLoadRangeX or objResetData[0] > Screen.CameraX + Screen.Width + objLoadRangeX
							{
								x			 = objResetData[0];
								y			 = objResetData[1];
								image_xscale = objResetData[2];
								image_yscale = objResetData[3];
								
								event_perform(ev_create,     0);
								event_perform(ev_room_start, 0);
							}
							
							// Else deactivate
							else
							{
								instance_deactivate_object(id);
							}
						}
						
						// Should object be deleted?
						else if objResetFlag == 2
						{					
							// Delete
							instance_destroy(id);
						}
					}
					
					// If not, unload
					else
					{
						instance_deactivate_object(id);
					}
				}
				
				// If no reset flag set, unload
				else
				{
					instance_deactivate_object(id);
				}
			}
			else if objResetFlag 
			{
				// If object is inside the limits and has the reset flag, allow it to be resetted
				if !variable_instance_exists(id, "objResetActive")
				{
					objResetActive = true;
				}
				 
				// Keep deactivated
				else if objResetFlag == 1
				{
					instance_deactivate_object(id);
				}
			}
		}	
	}
	
	// Activate unloaded objects inside of the largest region
	instance_activate_region(Screen.CameraX - 128, Screen.CameraY - 256, Screen.Width + 256, Screen.Height + 512, true);
}