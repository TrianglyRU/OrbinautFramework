// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.PAUSE);

depth = draw_depth(60);
launch_force = 10;
solid_offsets =
[
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	2, 2, 
	4, 4, 
	6, 6, 
	8, 8,
	10, 10,
	12, 12,
	14, 14,
	16, 16,
	18, 18, 20
];