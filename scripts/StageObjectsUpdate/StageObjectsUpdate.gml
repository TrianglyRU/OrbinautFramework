function StageObjectsUpdate() 
{	
	// List of objects to deactivate
	instance_deactivate_object(Objects);

	// Activate objects in a chuck of camera position rounded down to nearest 128
	if State != ActStateLoading
	{
		var Boundary128 = Screen.RenderX div 128 * 128;
		instance_activate_region(Boundary128, 0, Boundary128 + ceil(Screen.Width / 128) * 128, room_height, true);
	}
	
	// Stop all objects on player death
	if State = ActStatePlayerDeath
	{	
		with Objects if instance_exists(self)
		{	
			// Create layer and sprites on it
			layer_create(Player.DrawOrder + 1, "tempObjLayer");
			var Sprite = layer_sprite_create("tempObjLayer", x, y, sprite_index);
			layer_sprite_index(Sprite, image_index);

			// Set sprite speed
			sprite_set_speed(sprite_index, 0, spritespeed_framespersecond);
			
			// Destroy objects
			instance_destroy(self);
		}
	}
}