// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.NONE);

depth = draw_depth(20);
timer = 0;
vel_y = 0;
animator.start(sprite_index, 0, 0, 6);