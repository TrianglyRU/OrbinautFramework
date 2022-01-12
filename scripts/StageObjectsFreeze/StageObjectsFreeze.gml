function StageObjectsFreeze()
{	
	/* This event don't happen on the very first frame so ALL the objects will be
	active for that frame, but will they all will be deactivated on the next one */
	
	if DoUpdate
	{
		exit;
	}
	instance_deactivate_all(true);

	// List of objects to keep activated
	var IgnoreList = [Framework, Player, Stage, Input, Interface, Camera, Discord, Palette, Background, Audio];
	
	// Keep these objects active
	var Length = array_length(IgnoreList); 
	for (var i = 0; i < Length; i++)
	{
		instance_activate_object(IgnoreList[i]);
	}
}