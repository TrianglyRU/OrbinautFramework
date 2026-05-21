// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.DESTROY);

depth += 1;
animator.start(sprite_index, 0, 11, 2);