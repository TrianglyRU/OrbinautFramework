// Inherit the parent event
event_inherited();
event_animator();

vel_x = -1.5 * image_xscale;
vel_y = 1.5;
animator.start(sprite_index, 0, 0, 4);