// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.DESTROY);

#macro BUBBLE_FINAL_FRAME 5

enum BUBBLE
{
	SMALL,
	MEDIUM,
	LARGE,
	COUNTDOWN
}

burst = function()
{
	animator.start(spr_bubble_burst, 0, 1, 6);
}

if bubble_type == BUBBLE.COUNTDOWN
{
	animator.start(spr_countdown_bubble, 0, 4, 6);
}
else
{
	animator.start(sprite_index, bubble_type == BUBBLE.LARGE, 5, 15);
}

depth = draw_depth(10);
vel_y = -0.53125;
countdown_frame = 0;
wobble_offset = 0;
wobble_direction = 1;
wobble_data =
[
	 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
	 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
	 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2,
	 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
	 0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3,
	-3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,
	-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,
	-3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1
];