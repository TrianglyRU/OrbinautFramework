function PlayerKnuxGlide()
{
	if !AllowCollision or ClimbState
	{
		return;
	}
	
	// Collide with left wall
	var FindWall = tile_find_h(PosX - RadiusX, PosY, false, Layer);
	if  FindWall[0] <= 0
	{
		if !(Xsp > 0)
		{
			PosX -= FindWall[0];
			Xsp   = 0;
		
			// Attach to it
			if GlideState == GlideAir and Facing == FlipLeft and FindWall[1] mod 90 == 0
			{
				GlideState = false;
				Ysp		   = 0;
				ClimbValue = 0;
				ClimbState = ClimbWall;
				Animation  = AnimClimb;

				audio_sfx_play(sfxGrab, false); 
				return;
			}
		}	
	}
			
	// Collide with right wall
	var FindWall = tile_find_h(PosX + RadiusX, PosY, true, Layer);
	if  FindWall[0] <= 0
	{
		if !(Xsp < 0)
		{
			PosX += FindWall[0];
			Xsp   = 0;
		
			// Attach to it
			if GlideState == GlideAir and Facing == FlipRight and FindWall[1] mod 90 == 0
			{
				GlideState = false;
				Ysp		   = 0;
				ClimbValue = 0;
				ClimbState = ClimbWall;
				Animation  = AnimClimb;
			
				audio_sfx_play(sfxGrab, false); 
				return;
			}	
		}
	}
	
	// Collide with ceiling
	var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, noone, Layer);
	if  FindRoof[0] < 0
	{	
		Ysp   = 0;			
		PosY -= FindRoof[0];
	}
	
	// Collide with floor
	else if Ysp >= 0
	{
		var X1 = PosX - RadiusX;
		var X2 = PosX + RadiusX;
		var Y1 = PosY + RadiusY;
		var FindFloor = tile_find_2v(X1, Y1, X2, Y1, true, noone, Layer);
		
		// Are we airborne?
		if GlideState != GlideGround 
		{
			if ForcedRoll
			{
				PosY    += FindFloor[0];
				Grounded = true;
			}
			else if FindFloor[0] < 0
			{
				if FindFloor[1] <= 45 or FindFloor[1] >= 316.41
				{
					// If floor is shallow enough, change state
					if GlideState == GlideAir
					{
						GlideState = GlideGround;
						Animation  = AnimSlide;
						GlideValue = 8;
						Grv		   = 0;
						Ysp		   = 0;
					
						instance_create(PosX, PosY + RadiusY + FindFloor[0], DustPuff);
					}
					else if GlideState == GlideFall
					{
						Angle      = FindFloor[1];
						Grounded   = true;
						Xsp		   = 0;
						Ysp		   = 0;
						GroundLock = 16;
						Animation  = AnimDropStand;
						
						audio_sfx_play(sfxLand, false);
					}
				}
				else
				{
					if GlideState == GlideAir
					{
						Gsp	= FindFloor[1] > 180 ? -Xsp : Xsp;
					}
					else if GlideState == GlideFall
					{
						Gsp = -Xsp;
					}
					Angle	   = FindFloor[1];						
					GroundLock = 16;
					Grounded   = true;
				}
				
				// Adhere to the surface
				PosY += FindFloor[0];
			}
		}
		
		// Are we sliding?
		else 
		{
			if FindFloor[0] > 14
			{
				GlideState = GlideFall;
				Animation  = AnimGlideFall;
				RadiusX    = DefaultRadiusX;
				RadiusY	   = DefaultRadiusY;
					
				// Reset gravity
				if !IsUnderwater
				{
					Grv	= 0.21875;
				}
				else
				{
					// Reduce by 0x28 (0.15625) if underwater
					Grv = 0.0625
				}
			}
			else
			{
				// Adhere to the surface
				PosY += FindFloor[0];
				Angle = FindFloor[1];
			}
		}
	}
}