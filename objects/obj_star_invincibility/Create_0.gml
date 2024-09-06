// Inherit the parent event
event_inherited();
	
angle = 0;
angle_offset = 0;
frame_number = [0, 0];
frame_table1 = [0, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0, 0, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0];
frame_table2 = [0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
frame_table3 = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2];
frame_table4 = [6, 3, 5, 3, 3, 5, 3, 6, 3, 5, 5, 3];

obj_set_culling(CULLING.PAUSEONLY);
obj_set_priority(1);