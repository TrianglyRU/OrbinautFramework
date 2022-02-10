/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{
	// Activate region
	instance_activate_region((anchorX - 128) & -128, 0, ((400 + 128) & -128) + 256, room_height, true);	
	
	// Force-load children objects
	with Stage
	{
		event_perform(ev_other, ev_user0);
	}
}