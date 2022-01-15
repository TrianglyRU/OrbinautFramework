function InputUpdate() 
{
	if keyboard_check(vk_anykey)
	{
		Type = "Keyboard";
	}
	else if gamepad_is_connected(0) or gamepad_is_connected(4)
	{
		Type = "Gamepad";
	}
}