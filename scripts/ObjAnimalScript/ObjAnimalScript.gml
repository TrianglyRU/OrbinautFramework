function ObjAnimalScript()
{
	/*if FromCapsule
	{ 
		Ysp = 0; 
		Grv = 0;
		
		if CapsuleDelay 
		{
			CapsuleDelay--;
		}
		else
		{ 
			FromCapsule = false; 
			Ysp		    = -4; 
			Grv         = 0.21875; 
		}
	}*/
	
	// Update vertical speed
	Ysp  += Grv;
	PosY += Ysp;
	
	// Update y position
	y = floor(PosY);
	
	// Appear state
	if State == 0
	{
		// Stay at the first frame
		animation_set_frame(AnimalType, 1);
		
		// Check if animal colliding with the ground
		if Ysp > 0 
		{
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, LayerA)
			if  findFloor
			{
				// Reverse speed
		        Ysp = -4;
				
				// Set direction
			    image_xscale = FromCapsule ? choose(-1, 1) : -1;
				
				// Set horizontal speed
				Xsp	 *= image_xscale;
				
				// Set second frame
				animation_set_frame(AnimalType, 2);
				
				// Go to the next state
		        State = 1;
		    }
		}
	}
	
	// Leaving state
	else if State == 1
	{
		PosX += Xsp;
		Grv   = 0.09375;
		
		// Animate animal
		switch AnimalType
		{
			// Flicky
			case spr_obj_animal_flicky:
			{
				animation_play(AnimalType, 3, 2);
			}
			break;
			
			// Pocky
			case spr_obj_animal_pocky:
			{
				animation_set_frame(AnimalType, Ysp < 0 ? 2 : 3);
			}
			break;
		}
		 
		// Reverse speed when colliding ground
		if Ysp > 0
		{
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, LayerA)
			if  findFloor
			{
				Ysp = -4;
			}
		}
	}
	
	// Update x position
	x = floor(PosX);
	
	// Delete animal when outside the camera
	if x + 8 < Screen.CameraX or x - 8 > Screen.CameraX + Screen.Width
	{
		instance_destroy();
	}
}