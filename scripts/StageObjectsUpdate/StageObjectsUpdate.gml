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
		var IgnoreList  = [Framework, Player, Input, Screen, Stage, Discord, Palette, Spawnpoint];
		var ArrayLength = array_length(IgnoreList);	
		
		with all
		{
			// Exit the code if object is the one to ignore
			for (var i = 0; i < ArrayLength; i++)
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
		instance_activate_region(Screen.CameraX - 240, Screen.CameraY - 16, Screen.Width + 480, Screen.Height + 32, true);		
	}		
}