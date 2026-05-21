// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

depth = draw_depth(50);
retract_direction = sign(image_xscale);
retract_distance = 32;
retract_timer = 0;
retract_offset = 0;