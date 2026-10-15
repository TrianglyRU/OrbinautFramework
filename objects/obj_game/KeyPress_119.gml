/// @description Toggle Orbinaut Profiler
if global.dev_mode
{
	global.debug_framework++;
	global.debug_framework %= 3;
}