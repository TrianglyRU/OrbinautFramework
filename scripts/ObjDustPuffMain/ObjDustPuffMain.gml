function ObjDustPuffMain()
{
	// Play animation
	animation_play(sprite_index, 4, 4);
	
	// Check if player is skidding or sliding
	if Player.Animation == AnimSkid or Player.GlideState > GlideFall
	{
		if image_index == 1 and !State
		{
			// Create another dust object on the second frame
			instance_create(Player.PosX, Player.PosY + Player.RadiusY, DustPuff);
			
			// Increment state
			State++;
		}
	}
	
	// Destroy on animation end
	if image_index == 4
	{
		instance_destroy();
	}
}