function ObjBarrierStartup()
{
	// Set animation
	switch Player.BarrierType
	{
		case BarrierNormal:
			animation_set(spr_obj_barrier_normal, 2, 0, 0);
		break;
		case BarrierFlame:
			animation_set(spr_obj_barrier_flame, 2, 0, 0);
		break;
		case BarrierThunder:
			animation_set(spr_obj_barrier_thunder, 2, 0, 0);
		break;
		case BarrierWater:
			animation_set(spr_obj_barrier_water, 2, 0, 0);
		break;
	}
}