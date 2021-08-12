function StageObjectsInactiveProcess()
{
	// Exit if stage is updating
	if DoUpdate
	{
		exit;
	}

	// Deactivate all objects...
	instance_deactivate_all(true);
		
	// ...but keep ignored objects active
	var IgnoreList = [Framework, Player, Input, Screen, Discord, Palette, Background, InvincibilityStar, TailsObject, SuperStar, Barrier];
	var Length	   = array_length(IgnoreList);
		
	for (var i = 0; i < Length; i++)
	{
		instance_activate_object(IgnoreList[i]);
	}
}