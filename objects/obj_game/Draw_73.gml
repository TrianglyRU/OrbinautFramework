/// @description Set Up Per-View Draw End Calls
if room == rm_startup
{
	return;
}

// Disable all shaders
shader_reset();