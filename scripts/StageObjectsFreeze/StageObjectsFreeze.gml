function StageObjectsFreeze()
{	
	/* This event doesn't happen on the very first frame of the room so ALL the objects
	will be active for that frame, but will be deactivated on the next one
	
	This allows us to do some initialisation stuff in 
	GameInstsancesStartup() script from the Framework Controller
	*/
	
	if !UpdateObjects
	{
		instance_deactivate_all(true);
		var IgnoreList = 
		[
			Framework, 
			Player, 
			Stage, 
			Input, 
			Interface,
			Camera, 
			Discord, 
			Palette, 
			Background, 
			Audio
		];
		var Length = array_length(IgnoreList);
		
		for (var i = 0; i < Length; i++)
		{
			instance_activate_object(IgnoreList[i]);
		}
	}
}