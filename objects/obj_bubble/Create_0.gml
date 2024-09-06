#macro BUBBLE_TYPE_SMALL 0
#macro BUBBLE_TYPE_MEDIUM 1
#macro BUBBLE_TYPE_LARGE 2
#macro BUBBLE_TYPE_LARGE_BURST 3
#macro BUBBLE_TYPE_COUNTDOWN 4
#macro BUBBLE_FINAL_FRAME 5
	
// Inherit the parent event
event_inherited();
	
/// @method m_bubble_burst
m_bubble_burst = function()
{
	BubbleType = BUBBLE_TYPE_LARGE_BURST;
	ani_update_duration(6);
	ani_resume();
}
	
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
	
wobble_offset = 0;
wobble_offset_max = array_length(wobble_data) - 1;
vel_y = -0.53125;
	
var _duration = 15;
	
if BubbleType == BUBBLE_TYPE_COUNTDOWN
{	
	// Have a duration set for 5th (4th) frame because it technically is displayed
	_duration = [6, 12, 6, 6, 0];
}
	
obj_set_priority(1);
obj_set_culling(CULLING.REMOVE);
ani_start(sprite_index, _duration, 0, image_number - 1);