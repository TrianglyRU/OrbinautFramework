function MenuControlConfig()
{
	if MenuState == InputConfig and MenuOption < 9
	{	
		// Exit button assign state
		if ControlEditMode == true and keyboard_check_pressed(vk_anykey) 
		{
			Game.KeyboardControl[MenuOption] = string(keyboard_key);
			ControlEditMode					 = false;
			Input.IgnoreInput				 = false;
			keyboard_clear(keyboard_key);
		}
		// Enter button assign state
		else if (Input.APress == true or Input.StartPress == true) and ControlEditMode == false
		{
			ControlEditMode	  = true;
			Input.IgnoreInput = true;
		}
	}
}