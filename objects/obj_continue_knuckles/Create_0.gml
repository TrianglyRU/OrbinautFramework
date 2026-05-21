// Inherit the parent event
event_inherited();

vel_charge_target = 8;
vel_charge_acc = 0.125;
animation_data = [sprite_index, spr_knuckles_idle, spr_knuckles_walk, spr_knuckles_run];
animator.start(sprite_index, 0, 0, 12);