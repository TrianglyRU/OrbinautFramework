/// @description Insert description here
// You can write your code in this editor
	
	object_set_solidbox(8, 16, false);
	object_set_hitbox(16, 16);
	object_set_depth(Player, false);
	object_set_range(RangeClose, ResetRespawn);
	
	Dir   = image_xscale;
	Xsp   = 0.5;
	Timer = 128;
	Reset = false;
	PosX  = x;
	PosY  = y;
	sprite_index = spr_badnik_crabmeat_move;