/// @description
// You can write your code in this editor

	object_act_solid(true, true, true);
	
	if Player.Grounded and !Player.Spinning and Grounded
	{
		if floor(Player.PosX) > PosX and Input.Left
		{
			Direction	 = FlipLeft;
			var PushSide = SideRight;
		}
		else if floor(Player.PosX) < PosX and Input.Right
		{
			Direction	 = FlipRight;
			var PushSide = SideLeft;
		}
		else
		{
			Direction    = noone;
			var PushSide = noone;
		}
		if PushSide != noone and object_player_touch(PushSide)
		{
			// Move block
			PosX		+= PushSide == SideLeft ? 1 : - 1;
			Player.PosX += PushSide == SideLeft ? 1 : - 1;
		
			// Reset player's inertia
			Player.Inertia = PushSide == SideLeft ? 0.25 : -0.25;
		}
	}
	
	if !Grounded
	{
		if ClipTimer--
		{
			PosX += 4 * Direction;
		}
		else
		{
			Ysp      += 0.21875;
			PosY	 += Ysp;
		}	
	}
	
	// Update position
	object_update_position(PosX, PosY);
	
	if Direction != noone
	{
		object_collide_tiles_h(SideLeft,  SideCentre, 0, LayerA);
		object_collide_tiles_h(SideRight, SideCentre, 0, LayerA);
	}
	
	var CollisionCheck = object_collide_tiles_v(SideCentre, SideBottom, 0, LayerA);	
	if !CollisionCheck
	{
		if Grounded
		{
			ClipTimer = 4;
			Grounded  = false;
		}
	}
	else if !Grounded
	{
		Grounded  = true;
		Ysp		  = 0;
		ClipTimer = 4;
	}