// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.DESTROY);

depth = draw_depth(0);
animator.start(sprite_index, 0, 18, 2);