function MenuControlConfig()
{
	if MenuState == InputConfig and MenuOption < 9
	{	
		// Exit button assign state
		if ControlEditMode and keyboard_check_pressed(vk_anykey) 
		{
			Game.KeyboardControl[MenuOption] = string(keyboard_key);
			Input.IgnoreInput				 = false;
			ControlEditMode					 = false;
			keyboard_clear(keyboard_key);
		}
		// Enter button assign state
		else if (Input.APress or Input.StartPress) and !ControlEditMode
		{
			Input.IgnoreInput = true;
			ControlEditMode	  = true;	
		}
	}
}