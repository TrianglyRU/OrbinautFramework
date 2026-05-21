// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

#macro MASHER_VEL_Y_DEFAULT -5

depth = draw_depth(50);
vel_y = MASHER_VEL_Y_DEFAULT;