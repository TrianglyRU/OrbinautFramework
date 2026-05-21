// Inherit the parent event
event_inherited();

y += 2;
vel_charge_target = 8;
vel_charge_acc = 0.125;
animation_data = [sprite_index, spr_amy_idle, spr_amy_walk, spr_amy_run, spr_amy_dash];
animator.start(sprite_index, 0, 0, 6);