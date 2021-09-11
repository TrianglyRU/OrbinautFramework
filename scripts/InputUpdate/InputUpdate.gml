function InputUpdate() 
{
	// Script subfunction
	function InputUpdate_SubFunc()
	{
		// Check if any gamepad button or axis is pressed
		for (var i = gp_face1; i < gp_axislh; i++)
		{
			if gamepad_button_check(0, i)
			{
				return i;
			}		
		}
		for (var i = gp_axislh; i <= gp_axisrv; i++)
		{
			if gamepad_axis_value(0, i)
			{
				return i;
			}		
		}
		return false;
	}
	
	switch Type 
	{	
		// Switch from keyboard to gamepad
		case "Keyboard":
		{
			if InputUpdate_SubFunc()
			{
				Type = "Gamepad";
			}
		}
		break;
		
		// Switch from gamepad to keyboard
		case "Gamepad":
		{
			if keyboard_check_pressed(vk_anykey) 
			{
				Type = "Keyboard";
			}				
		}
		break;
		
		// Use keyboard by default
		default:
		{
			Type = "Keyboard";	
		}
		break;
	}	
}