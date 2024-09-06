// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST;
offset_x = array_create(CAMERA_COUNT, undefined);
offset_y = array_create(CAMERA_COUNT, undefined);
	
var _duration = 
[
	12, 8, 8, 8, 8, 8, 8, 8
];
	
var _order =
[
	CountdownFrame, 6, CountdownFrame, 6, CountdownFrame, 6, CountdownFrame, 6
];
	
ani_start(sprite_index, _duration, 0, 7, _order);