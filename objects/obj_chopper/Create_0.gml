// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

#macro CHOPPER_VEL_Y_DEFAULT -7

depth = draw_depth(50);
vel_y = CHOPPER_VEL_Y_DEFAULT;