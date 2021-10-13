function StageObjectsFreeze()
{
	// Exit if stage is updating
	if DoUpdate
	{
		exit;
	}
	
	// Deactivate all objects (even if they were activated on this frame)
	instance_deactivate_all(true);
		
	// Keep controllers and several objects active
	var IgnoreList = [Framework, Player, Input, Interface, Camera, Discord, Palette, Background, Audio, StarPostEffect, SpecialRing];
	var Length	   = array_length(IgnoreList);	
	for (var i = 0; i < Length; i++)
	{
		instance_activate_object(IgnoreList[i]);
	}
}