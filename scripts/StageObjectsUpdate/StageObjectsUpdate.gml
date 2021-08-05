function StageObjectsUpdate() 
{	
	// Get ignore list
	var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint, Palette];
	var Length = array_length(IgnoreList);
	
	// Check if player died
	if Player.Death or State == StageUnload
	{			
		// Stop player
		if State == StageUnload
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
		
		// Update objects
		with all
		{
			// Exit the code if object is the one to ignore
			for (var i = 0; i < Length; i++)
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
		// Update objects
		with all
		{
			// Pause all objects if stage is paused
			if Stage.State == StagePaused
			{
				// Exit the code if object is the one to ignore
				for (var i = 0; i < Length; i++)
				{
					if object_index == IgnoreList[i]
					{
						exit;
					}
				}
				instance_deactivate_object(id);
			}
			
			// Check if object can be unloaded
			else if variable_instance_exists(id, "Obj_LoadFlag")
			{	
				// Get position
				var ObjectX = floor(x);
				var ObjectY = floor(y);
			
				// Get limits
				var LeftBound   = Screen.CameraX - Obj_LoadX;
				var TopBound    = Screen.CameraY - Obj_LoadY;
				var RightBound  = Screen.CameraX + Screen.Width  + Obj_LoadX;
				var BottomBound = Screen.CameraY + Screen.Height + Obj_LoadY;
			
				// Check if the object is off-limits
				if ObjectX < LeftBound or ObjectX > RightBound
				or ObjectY < TopBound  or ObjectY > BottomBound
				{
					// Is reset flag set?
					if Obj_LoadFlag != false
					{
						// Was object on the screen before?
						if Obj_LoadState
						{
							// Should object be deactivated?
							if Obj_LoadFlag == ResetUnload
							{
								// Then deactivate!
								instance_deactivate_object(id);
							}
							
							// Should object be resetted to its initial state?
							else if Obj_LoadFlag == ResetRespawn
							{
								// Reset object if its initial position if off-limits
								if Obj_LoadData[0] < Screen.CameraX - Obj_LoadX or Obj_LoadData[0] > Screen.CameraX + Screen.Width + Obj_LoadX
								{
									x			 = Obj_LoadData[0];
									y			 = Obj_LoadData[1];
									image_xscale = Obj_LoadData[2];
									image_yscale = Obj_LoadData[3];
								
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
							else if Obj_LoadFlag == ResetDelete
							{	
								// Delete
								instance_destroy(id);
							}
						}
					
						// If not, just unload
						else
						{
							instance_deactivate_object(id);
						}
					}
				}
			
				// If object is inside the limits and has the reset flag, allow unload actions
				else if Obj_LoadFlag != false and !Obj_LoadState
				{
					Obj_LoadState = true;		
				}
			}
		}
		
		// Activate unloaded objects inside of the largest region
		instance_activate_region(Screen.CameraX - 128, Screen.CameraY - 256, Screen.Width + 256, Screen.Height + 512, true);
	}		
}