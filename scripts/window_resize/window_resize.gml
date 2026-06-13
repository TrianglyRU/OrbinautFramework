/// @self
/// @description Resizes the game window to match the current internal resolution and scale factor.
function window_resize()
{
	window_set_size(RENDER_APPLICATION_WIDTH * global.window_scale, RENDER_APPLICATION_HEIGHT * global.window_scale);
	window_center();
}