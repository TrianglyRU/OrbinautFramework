// Inherit the parent event
event_inherited();

obj_set_culling(CULLING.REMOVE);
ani_start(sprite_index, 2, 0, 12, [0, 3, 0, 3, 1, 3, 1, 3, 1, 3, 2, 2, 3]);