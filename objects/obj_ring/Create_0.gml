#macro RING_STATE_STATIC 0
#macro RING_STATE_DROP 1
#macro RING_STATE_ATTRACT 2
	
// Inherit the parent event
event_inherited();
	
obj_set_hitbox(6, 6);
obj_set_priority(1);
obj_set_culling(CULLING.DISABLE);
		
if State == RING_STATE_DROP
{
	obj_set_priority(3);
	obj_set_culling(CULLING.REMOVE);
		
	ani_start(sprite_index, 2);
}