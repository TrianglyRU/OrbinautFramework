// Inherit the parent event
event_inherited();

// Adjust bound triggers to account different resolutions
var _h_res = global.init_resolution_h;

if _h_res <= 224
{
	return;
}

var _h_diff = (_h_res - 224) * 0.5;

with obj_trigger_bound
{
	y += _h_diff * sign(image_yscale);
}