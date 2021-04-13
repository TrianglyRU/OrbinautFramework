function object_collide_tiles(startX, startY, angRange, tileLayer)
{
	switch angRange
	{
		case RangeFloor:
		{		
			// Get tiles
			var floorDistance = tile_check_collision_v(startX, startY, true, false, tileLayer)[0];
			
			// Update object position
			if floorDistance < 14 and floorDistance > -14
			{
				y += floorDistance + 1;
			}
		}
		break;		
	}
}