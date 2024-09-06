// Inherit the parent event
event_inherited();
	
osc_angle = 0;
chain_size = 16;
range = AngleRange / 2;
distance = ChainAmount * chain_size - chain_size / 2;
sprite_index = PlatformSprite;

obj_set_solid(floor(CollisionWidth / 2), floor(CollisionHeight / 2));
obj_set_priority(4);
obj_set_culling(CULLING.ORIGINDISABLE);