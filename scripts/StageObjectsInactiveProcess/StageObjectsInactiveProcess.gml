function StageObjectsInactiveProcess()
{
	// Exit if stage is updating
	if DoUpdate
	{
		exit;
	}

	// Deactivate all objects...
	instance_deactivate_all(true);
		
	// ...but keep controllers active
	var IgnoreList = [Framework, Player, Input, Interface, Camera, Discord, Palette, Background, Audio];
	var Length	   = array_length(IgnoreList);
		
	for (var i = 0; i < Length; i++)
	{
		instance_activate_object(IgnoreList[i]);
	}
}