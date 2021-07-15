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
		
		// Do code from object side
		with all
		{
			// Exit the code if object is the one to ignore
			var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint];
			for (var i = 0; i < array_length(IgnoreList); i++)
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
		// Activate all objects
		instance_activate_region(Screen.CameraX - 240, Screen.CameraY - 256, Screen.Width + 480, Screen.Height + 512, true);
	
		// Check for all objects
		with all
		{
			// Was object_set_activerange function used?
			if variable_instance_exists(id, "objActiveRange")
			{
				// Unload flag is either 1 (close) or 7 (far), resulting in boundary of 32/240 and 18/128	
				var UnloadX = 32 * objActiveRange	
				var UnloadY = 18 * objActiveRange;
			
				// Deactivate
				if floor(x) < Screen.CameraX - UnloadX or floor(x) > Screen.CameraX + Screen.Width  + UnloadX
				or floor(y) < Screen.CameraY - UnloadY or floor(y) > Screen.CameraY + Screen.Height + UnloadY
				{
					instance_deactivate_object(id);
				}
			}
		}	
	}		
}