#macro AIRBUBBLER_STATE_IDLE 0
#macro AIRBUBBLER_STATE_PRODUCE 1
	
// Inherit the parent event
event_inherited();

/// @method m_air_bubbler_set_delay
m_air_bubbler_set_delay = function()
{
	return irandom_range(128, 255);
}
	
state = AIRBUBBLER_STATE_IDLE;
random_time = 0;
wait_time = m_air_bubbler_set_delay();
wait_cycle = 0;
bubbles_to_spawn = 0;
bubble_id = 0;
bubble_id_large = 0;
type_array_to_use = 0;
type_array =
[
	[0, 0, 0, 0, 1, 0],		// Refer to BUBBLE_TYPE macro
	[0, 0, 0, 1, 0, 0],
	[1, 0, 1, 0, 0, 0],
	[0, 1, 0, 0, 1, 0]
];
	
obj_set_priority(1);
obj_set_culling(CULLING.DISABLE);
ani_start(sprite_index, 16);