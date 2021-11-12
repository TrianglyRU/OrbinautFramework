function ObjDustPuffMain()
{
	// Check if player is skidding or sliding
	if Player.Animation == AnimSkid and Player.Grounded or Player.GlideState > GlideFall
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