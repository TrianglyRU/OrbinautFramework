function ObjDustPuffMain()
{
	// Play animation
	animation_play(sprite_index, 4, 5);
	
	// Create another dust object after 4 frames
	if Player.Animation == AnimSkid and !SpawnDust
	{
		if animation_get_frame(id) == 2
		{
			// Spawn
			instance_create(floor(Player.PosX), floor(Player.PosY + Player.RadiusY), DustPuff);
			
			// Set flag
			SpawnDust = true;
		}
	}
	
	// Destroy on animation end
	if animation_get_frame(id) == 5
	{
		instance_destroy();
	}
}