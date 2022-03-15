/// @description Startup
// You can write your code in this editor
	
	FlameAnimationTime = 25;
	
	switch Player.BarrierType
	{
		case BarrierNormal:
			animation_play(spr_obj_barrier_normal, 4, 0);
		break;
		case BarrierFlame:
			animation_play(spr_obj_barrier_flame, 2, 0);
		break;
		case BarrierThunder:
			animation_play(spr_obj_barrier_thunder, 2, 0);
		break;
		case BarrierWater:
			animation_play(spr_obj_barrier_water, 2, 0);
		break;
	}
	
	// Set object properties
	object_set_depth(Player, 1);