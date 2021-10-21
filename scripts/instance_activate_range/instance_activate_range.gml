/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{
	instance_activate_region((anchorX - 128) & -128, 0, ((Game.Width + 128) & -128) + 256, room_height, true);
}