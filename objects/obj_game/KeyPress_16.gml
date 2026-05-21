/// @description Toggle Bounding Boxes
if global.dev_mode && keyboard_check(vk_rshift)
{
	global.debug_collision = !global.debug_collision;
}