// Inherit the parent event
event_inherited();

launch_force = 10;
	
var _height_map = 
[
	16,16,16,16,16,16,16,16,16,16,16,16,16,14,14,12,12,10,10,8,8,6,6,4,4,2,2,0,0,-2,-2,-4
];
	
obj_set_solid_sloped(_height_map);
obj_set_priority(5);
obj_set_culling(CULLING.DISABLE);	
ani_start(sprite_index, 3);