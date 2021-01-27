function StageActInitialization()
{	
	// Disable collision showcase
	//CollisionMasks.visible = true;
	with CollisionMasks
	{
		sprite_collision_mask(sprite_index, false, 1, 0, 0, 0, 0, 0, 0);
	}
	switch room 
	{
		// Moonlight Base
		case MBZ:
			CardName				= "MOONLIGHT BASE";	
			TimeEnabled				= false;	
			CardEnabled				= true;	
			ZoneID					= 10; 
			ActID					= 0;	
			WaterLevel				= 0;	
			Time					= 0;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
			LastCheckpoint			= Game.SavedCheckpoint;	
			State					= ActStateDefault;
		break;	
	}	
}