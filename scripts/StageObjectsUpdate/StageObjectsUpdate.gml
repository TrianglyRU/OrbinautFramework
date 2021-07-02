function StageObjectsUpdate() 
{		
	// Unload far objects
	instance_deactivate_object(UnloadFar);
	
	// Load far objects in a given region
	if State != ActStateLoading
	{
		instance_activate_region(Screen.CameraX - 128, Screen.CameraY - 256, Screen.Width + 256, Screen.Height + 512, true);
	}
	
	// Unload close objects
	instance_deactivate_object(UnloadClose);
	
	// Load close objects in a given region
	if State != ActStateLoading
	{
		instance_activate_region(Screen.CameraX - 32, Screen.CameraY, Screen.Width + 64, Screen.Height, true);
	}
	
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
			
			// Create this object current sprite on its position
			var ObjectSprite = layer_sprite_create("Objects", x, y, sprite_index);
			
			// Set sprite properties
			layer_sprite_speed(ObjectSprite,  0);
			layer_sprite_alpha(ObjectSprite,  visible ? image_alpha : 0);
			layer_sprite_index(ObjectSprite,  image_index);
			layer_sprite_xscale(ObjectSprite, image_xscale);
			layer_sprite_yscale(ObjectSprite, image_yscale);

			// Destroy object
			instance_destroy();
		}
	}
}