/// @self
/// @description Toggles the fade effect for all subsequent drawing calls.
/// @param {Bool} enabled A boolean flag to enable or disable the fade effect.
function draw_toggle_fade(_enabled)
{
	shader_set_uniform_i(global.sh_fade_active, _enabled);
}