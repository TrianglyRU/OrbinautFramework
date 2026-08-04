/// @description Set Up Draw Calls
if room == rm_startup
{
	return;
}

var _timer;

if fade_type == FADE_TYPE.DULL_ORDER || fade_type == FADE_TYPE.DULL_SYNC || fade_type == FADE_TYPE.FLASH_ORDER || fade_type == FADE_TYPE.FLASH_SYNC
{
	_timer = round(fade_timer / 3);
}
else
{
	_timer = fade_timer;
}


// Set fade filter parameters for the current view
if fade_effect != -1
{
	fx_set_parameter(fade_effect, "g_Type", fade_type);
	fx_set_parameter(fade_effect, "g_Timer", _timer);	
}

// Set fade shader parameters for the current view (and disable it right after, we're not using it by default)
shader_set(sh_rgb_fade);
shader_set_uniform_i(shader_get_uniform(sh_rgb_fade, "u_type"), fade_type);
shader_set_uniform_f(shader_get_uniform(sh_rgb_fade, "u_timer"), _timer);
shader_reset();

// Clear palette tracking stuff
palette_entry_current = undefined;
palette_entry_previous = undefined