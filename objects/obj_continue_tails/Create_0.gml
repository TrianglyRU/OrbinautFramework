// Inherit the parent event
event_inherited();

y += 3;
vel_charge_target = 8;
vel_charge_acc = 0.125;
animation_data = [sprite_index, spr_tails_idle, spr_tails_walk, spr_tails_run, spr_tails_dash];
animator.start(sprite_index, 0, 0, 24);