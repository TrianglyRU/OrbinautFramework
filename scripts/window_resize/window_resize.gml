/// @self
/// @description Resizes the game window to match the current internal resolution and scale factor.
function window_resize()
{
	window_set_size(resolution_width * global.window_scale, resolution_height * global.window_scale);
	window_center();
}