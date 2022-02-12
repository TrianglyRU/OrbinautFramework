function ObjDustPuffMain()
{
	// Destroy on animation end
	if image_index == 4
	{
		instance_destroy();
	}
	
	if Player.DebugMode
	{
		return;
	}
	if !(Player.Animation == AnimSkid or Player.GlideState > GlideFall)
	{
		return;
	}

	// Create another dust object on the second frame
	if image_index == 1 and !State
	{	
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