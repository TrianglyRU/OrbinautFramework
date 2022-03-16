/// @description Process Frozen Objects
// You can call your scripts in this editor
	
	/* This event doesn't happen on the very first frame of the room so ALL the objects
	will be active for that frame, but will be deactivated on the next one
	
	This allows us to do some initialisation stuff in 
	Room Start event of the Framework Controller
	*/
	
	if !UpdateObjects
	{
		instance_deactivate_all(true);
		
		// Activate controllers back, we need them!
		var IgnoreList = 
		[
			Framework, 
			Player,
			Input, 
			Interface,
			Camera, 
			Discord, 
			Palette,
			Renderer,
			Background, 
			Audio
		];
		
		var Length = array_length(IgnoreList);
		for (var i = 0; i < Length; i++)
		{
			instance_activate_object(IgnoreList[i]);
		}
	}