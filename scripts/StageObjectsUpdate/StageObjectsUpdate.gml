function StageObjectsUpdate() 
{	
	// Check if player died or stage unloads
	if Player.Death or State == ActStateUnload
	{			
		// Stop player
		if State == ActStateUnload
		{
			with Player
			{
				// Create player sprite
				var PlayerSprite = layer_sprite_create("Objects", x + Xsp, y + Ysp, sprite_index);
				
				// Set sprite properties
				layer_sprite_speed(PlayerSprite,  0);
				layer_sprite_alpha(PlayerSprite,  image_alpha);
				layer_sprite_index(PlayerSprite,  image_index);
				layer_sprite_xscale(PlayerSprite, image_xscale);
				layer_sprite_yscale(PlayerSprite, image_yscale);
			}
		}
		
		var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint, Palette];
		var Len = array_length(IgnoreList);
		
		// Do code from object side
		with all
		{
			// Exit the code if object is the one to ignore
			for (var i = 0; i < Len; i++)
			{
				if object_index == IgnoreList[i]
				{
					exit;
				}
			}
			
			// Create blank object
			var ObjectSprite = instance_create_depth(x, y, depth, BlankObject);
			
			// Setup blank object
			ObjectSprite.visible	  = visible;
			ObjectSprite.sprite_index = sprite_index;
			ObjectSprite.image_index  = image_index;		
			ObjectSprite.image_xscale = image_xscale;
			ObjectSprite.image_yscale = image_yscale;
			ObjectSprite.image_speed  = 0;

			// Destroy main object
			instance_destroy();
		}
	}
	else
	{
		// Do code from object side
		with all
		{
			// Check if object can be unloaded
			if variable_instance_exists(id, "objResetFlag")
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
						if objResetActive
						{
							// Should object be resetted to its initial state?
							if objResetFlag == 1
							{
								// Reset object if its initial position if off-limits
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
			
				// If object is inside the limits and has the reset flag, allow it to be resetted
				else if objResetFlag and !objResetActive
				{
					objResetActive = true;		
				}
			}
		}
		
		// Activate unloaded objects inside of the largest region
		instance_activate_region(Screen.CameraX - 128, Screen.CameraY - 256, Screen.Width + 256, Screen.Height + 512, true);
	}		
}