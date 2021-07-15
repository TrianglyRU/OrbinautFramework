function ObjMotobugMain()
{
	// Is motobug currently stopped?
	if StopTimer 
	{
		// Count down the timer
		StopTimer--;
		
		// Flip Motobug and restore its speed
		if !StopTimer
		{
			Xsp		   =  1;
			Direction *= -1;
		}
	}
	
	// Move Motobug
	PosX += Xsp * Direction;
	
	// Is Motobug currently moving?
	if Xsp != 0
	{
		// Collide tiles & check for if Motobug is 2 pixels away from the surface
		var CollideFloor = object_collide_tiles_v(false, SideBottom, 2, LayerA);
		if !CollideFloor
		{
			// Stop Motobug
			StopTimer = 60;
			Xsp       = 0;
		}
	}

	// Act as badnik
	object_act_enemy(EnemyBadnik);
}