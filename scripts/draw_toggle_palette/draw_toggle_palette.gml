/// @self
/// @description Toggles colour palette replacement for all subsequent drawing calls.
/// @param {Bool} enabled A boolean flag to enable or disable the colour palette replacement.
function draw_toggle_palette(_enabled)
{
	shader_set_uniform_i(global.sh_pal_active, _enabled);
}