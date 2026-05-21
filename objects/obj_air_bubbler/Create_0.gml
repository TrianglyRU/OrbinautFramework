// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum AIR_BUBBLER_STATE
{
	IDLE,
	PRODUCE
}

get_random_delay = function()
{
	return irandom_range(128, 255);
}

depth = draw_depth(10);
state = AIR_BUBBLER_STATE.IDLE;
wait_time = get_random_delay();
wait_cycle = 0;
random_time = 0;
bubbles_to_spawn = 0;
bubble_id = 0;
bubble_id_large = 0;
type_array_to_use = 0;
type_array =
[
	[0, 0, 0, 0, 1, 0],
	[0, 0, 0, 1, 0, 0],
	[1, 0, 1, 0, 0, 0],
	[0, 1, 0, 0, 1, 0]
];

animator.start(sprite_index, 0, 0, 16);