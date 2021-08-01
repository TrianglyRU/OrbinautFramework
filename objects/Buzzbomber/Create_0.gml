/// @description Insert description here
// You can write your code in this editor

	object_set_hitbox(24, 12);
	object_set_depth(Player, false);
	object_set_range(RangeFar, ResetRespawn);
	
	Way     = 500;
	InitX   = x;
	Delay   = 0;
	Action  = 0;
	InitDir = image_xscale;
	Dir		= image_xscale; 
	Bullet  = noone;