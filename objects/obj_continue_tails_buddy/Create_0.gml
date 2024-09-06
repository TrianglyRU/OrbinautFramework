// Inherit the parent event
event_inherited();
	
// Override data
vel_charge_target = 7.125;
vel_charge_acc = 0.09375;
animation_data = [sprite_index, spr_tails_idle, spr_tails_walk, spr_tails_run, spr_tails_dash];
	
ani_start(sprite_index, 10);