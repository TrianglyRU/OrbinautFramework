// Inherit the parent event
event_inherited();
event_animator();

depth += 2;
vel_x = 1 * image_xscale;
vel_y = -4;
grv = 0.21815;
animator.start(sprite_index, 0, 0, 2);