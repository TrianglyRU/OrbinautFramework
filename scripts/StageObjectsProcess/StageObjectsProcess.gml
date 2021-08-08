function StageObjectsProcess() 
{	
	// Define object array to ignore
	var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint, Palette, BlankObject];
	var Length = array_length(IgnoreList);
	
	// Is stage update enabled?
	if DoUpdate
	{
		// Destroy the layer we stored sprites on
		if layer_exists("TempSprites")
		{
			layer_destroy("TempSprites");
		}
		
		with all
		{
			if variable_instance_exists(id, "Obj_LoadFlag")
			{	
				// Get object position
				var ObjectX = floor(x);
				var ObjectY = floor(y);
			
				// Get load bounds
				var LeftBound   = Screen.CameraX - Obj_LoadX;
				var TopBound    = Screen.CameraY - Obj_LoadY;
				var RightBound  = Screen.CameraX + Screen.Width  + Obj_LoadX;
				var BottomBound = Screen.CameraY + Screen.Height + Obj_LoadY;
			
				// Check if the object is off-boundaries
				if ObjectX < LeftBound or ObjectX > RightBound
				or ObjectY < TopBound  or ObjectY > BottomBound
				{
					if Obj_LoadFlag != false
					{
						// Was object on the screen before?
						if Obj_LoadState
						{
							// Unload object...
							if Obj_LoadFlag == TypeUnload
							{
								instance_deactivate_object(id);
							}
							
							// ...or reset it to its initial state
							else if Obj_LoadFlag == TypeReset
							{
								if Obj_LoadData[0] < Screen.CameraX - Obj_LoadX or Obj_LoadData[0] > Screen.CameraX + Screen.Width + Obj_LoadX
								{
									x			 = Obj_LoadData[0];
									y			 = Obj_LoadData[1];
									image_xscale = Obj_LoadData[2];
									image_yscale = Obj_LoadData[3];
								
									event_perform(ev_create,     0);
									event_perform(ev_room_start, 0);
								}
								else
								{
									instance_deactivate_object(id);
								}
							}
						
							// ... or delete completely
							else if Obj_LoadFlag == ResetDelete
							{	
								instance_destroy(id);
							}
						}
					
						// If object wasn't on the screen yet, unload
						else
						{
							instance_deactivate_object(id);
						}
					}
				}
			
				// If object is inside the boundaries and has the reset flag, allow unload actions
				else if Obj_LoadFlag != false and !Obj_LoadState
				{
					Obj_LoadState = true;		
				}
			}
		}
		
		// Activate unloaded objects inside of the largest region
		instance_activate_region(Screen.CameraX - 128, Screen.CameraY - 256, Screen.Width + 256, Screen.Height + 512, true);
	}
	
	// Is stage not updating?
	else
	{
		// Create layer to display sprites on
		if !layer_exists("TempSprites")
		{
			layer_create(layer_get_depth("Objects"), "TempSprites");
		}
		
		with all
		{
			// Exit if current object is the one to ignore
			for (var i = 0; i < Length; i++)
			{
				if object_index == IgnoreList[i]
				{
					exit;
				}
			}
			
			// Create and setup object sprite on the layer
			if !Player.Death
			{
				if visible and !Stage.IsPaused
				{
					var ObjectSprite = layer_sprite_create("TempSprites", x, y, sprite_index);
					layer_sprite_speed(ObjectSprite,  0);
					layer_sprite_alpha(ObjectSprite,  image_alpha);
					layer_sprite_index(ObjectSprite,  image_index);
					layer_sprite_xscale(ObjectSprite, image_xscale);
					layer_sprite_yscale(ObjectSprite, image_yscale);
				}
				
				// Deactivate object
				instance_deactivate_object(id);
			}
			
			// Replace objects with blank ones when player dies
			else
			{
				var ReplacedObject		    = instance_create_depth(x, y, depth, BlankObject);
				ReplacedObject.visible	    = visible;
				ReplacedObject.sprite_index = sprite_index;
				ReplacedObject.image_index  = image_index;		
				ReplacedObject.image_xscale = image_xscale;
				ReplacedObject.image_yscale = image_yscale;
				ReplacedObject.image_speed  = 0;

				// Destroy main object
				instance_destroy();
			}
		}
	}
}