/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{	
	// Load region
	instance_activate_region((anchorX & -128) - 128, 0, 128 + global.Width + 320, room_height, true);
}