/// @function input_gp_axis_pressed(device, axisindex)
function input_gp_axis_pressed(Device, Axis) 
{
	switch Axis 
	{
		case "gp_axis_lup":    return gamepad_axis_value(Device, gp_axislv) < 0 and !Input.Up;    break;
		case "gp_axis_ldown":  return gamepad_axis_value(Device, gp_axislv) > 0 and !Input.Down;  break;
		case "gp_axis_lleft":  return gamepad_axis_value(Device, gp_axislh) < 0 and !Input.Left;  break;
		case "gp_axis_lright": return gamepad_axis_value(Device, gp_axislh) > 0 and !Input.Right; break;
	}
}