function StageObjectsFreeze()
{	
	/* This event don't happen on the very first frame so ALL the objects will be
	active for that frame, but will they all will be deactivated on the next one */
	
	// Exit if stage is updating
	if DoUpdate
	{
		exit;
	}
	
	// Deactivate all objects and destroy children (even if they were activated on this frame)
	instance_deactivate_all(true);

	// List of objects to keep active (controllers in our case)
	var IgnoreList = [Framework, Player, Stage, Input, Interface, Camera, Discord, Palette, Background, Audio];
	
	// Activate these objects
	var Length = array_length(IgnoreList); 
	for (var i = 0; i < Length; i++)
	{
		instance_activate_object(IgnoreList[i]);
	}
}