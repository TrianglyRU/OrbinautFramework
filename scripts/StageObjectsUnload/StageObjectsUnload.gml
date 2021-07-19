function StageObjectsUnload()
{
	// Check for all objects
	with all
	{
		if object_index == BlankObject
		{
			
		}
		
		// Was object_set_activerange function used?
		else if variable_instance_exists(id, "objLoadRange")
		{
			// Unload flag is either 1 (close) or 7 (far), resulting in boundary of 32/240 and 18/128	
			var UnloadX = 32 * objLoadRange;
			var UnloadY = 18 * objLoadRange;
				
			var ObjectX = floor(x);
			var ObjectY = floor(y);
				
			// Outside the screen?
			if ObjectX < Screen.CameraX - UnloadX or ObjectX > Screen.CameraX + Screen.Width  + UnloadX
			or ObjectY < Screen.CameraY - UnloadY or ObjectY > Screen.CameraY + Screen.Height + UnloadY
			{
				// First-load deactivation
				if !objResetFlag
				{
					instance_deactivate_object(id);
				}
					
				// After being on the screen at least once
				if objResetFlag
				{	
					// Fully reset state?
					if objResetFlag2
					{
						// InitPos outside the screen too?
						/*if objResetX < Screen.CameraX - UnloadX or objResetX > Screen.CameraX + Screen.Width + UnloadX
						{	
							if object_index != BlankObject
							{
								instance_create(objResetX, objResetY, object_index);
								instance_destroy(id);
							}
							else
							{
								instance_create(InitialX, InitialY, InitialObject);
								instance_destroy(id);
							}
						}
							
						// Just deactivate
						else*/
						{
							// Remember this object
							var ThisObj = object_index;
							
							// Create a blank one instead
							var  NewObj = instance_create(0, 0, BlankObject, false);
							with NewObj
							{
								InitialObject = ThisObj;
								InitialX      = ThisObj.objResetX;
								InitialY      = ThisObj.objResetY;
							}
							
							instance_destroy(id);
						}
					}
						
					// Unload if outside the screen
					else
					{
						instance_deactivate_object(id);
					}
				}
			}
				
			// Inside the screen?
			else if !objResetFlag
			{
				// Set the flag the object was in the view at least once
				objResetFlag = true;
			}
		}	
	}
}