function GroupObjectsStop()
{	
	if Stage.State = ActStatePlayerDeath
	{	
		if instance_exists(self)
		{	
			// Create layer and sprites on it
			layer_create(Player.DrawOrder + 1, "ObjectSprites");
			var Sprite = layer_sprite_create("ObjectSprites", x, y, sprite_index);
			layer_sprite_index(Sprite, image_index);

			// Set sprite speed
			sprite_set_speed(sprite_index, 0, spritespeed_framespersecond);
			
			// Destroy objects
			instance_destroy(self);
		}
	}
}