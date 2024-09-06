// Inherit the parent event
event_inherited();

obj_set_priority(0);
obj_set_culling(CULLING.REMOVE);
ani_start(sprite_index, [2, 2, 2, 2, 4, 4, 4, 0], 0, 6);