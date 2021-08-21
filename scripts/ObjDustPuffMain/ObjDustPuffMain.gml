function ObjDustPuffMain()
{
	// Play animation
	animation_play(sprite_index, 4, 5);
	
	// Create another dust object after 4 frames
	if Player.Animation  == AnimSkid    and Player.Grounded
	or Player.GlideState == GlideActive and Player.GlideGrounded
	{
		if image_index == 1 and !SpawnDust
		{
			instance_create(floor(Player.PosX), floor(Player.PosY + Player.RadiusY), DustPuff);
			SpawnDust = true;
		}
	}
	
	// Destroy on animation end
	if image_index == 4
	{
		instance_destroy();
	}
}