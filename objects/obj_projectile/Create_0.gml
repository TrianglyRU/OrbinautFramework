// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.DESTROY);

depth -= 1;
is_reflected = false;
vel_x = 0;
vel_y = 0;
grv = 0;