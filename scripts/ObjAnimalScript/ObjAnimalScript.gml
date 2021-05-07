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
	
	Ysp  += Grv;
	PosY += Ysp;	
	y = floor(PosY);

	
	if State == 0
	{
		// Stay at the first frame
		animation_set_frame(AnimalType, 1);
		
		if Ysp > 0 
		{
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, LayerA)
			if  findFloor
			{
		        Ysp = -4;
				
			    image_xscale = FromCapsule ? choose(-1, 1) : -1;
				Xsp	 *= image_xscale; 
		        State = 1;
				animation_set_frame(AnimalType, 2);
		    }
		}
	}
	else if State == 1
	{
		PosX += Xsp;
		Grv   = 0.09375;
		
		animation_play(AnimalType, 3, 2); 
		
		if Ysp > 0
		{
			object_collide_tiles_v(false, SideBottom, 0, LayerA)
		}
	}
	
	x = floor(PosX);
	
	if x + 8 < Screen.CameraX or x - 8 > Screen.CameraX + Screen.Width
	{
		instance_destroy();
	}
}