function ObjDustPuffMain()
{
	// Check if player is skidding or sliding
	if (Player.Animation == AnimSkid or Player.GlideState > GlideFall) //and !Player.DebugMode
	{
		if image_index == 1 and !State
		{
			// Create another dust object on the second frame
			var  ThisObject = id;
			var  NewObject  = instance_create(Player.PosX, Player.PosY + Player.RadiusY, DustPuff);
			with NewObject
			{
				object_set_depth(ThisObject, 1);
			}
			
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