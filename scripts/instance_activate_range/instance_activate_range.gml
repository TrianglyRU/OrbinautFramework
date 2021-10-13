/// @function instance_activate_range()
function instance_activate_range()
{
	instance_activate_region((Camera.ViewX - 128) & -128, 0, ((Game.Width + 128) & -128) + 256, room_height, true);
}