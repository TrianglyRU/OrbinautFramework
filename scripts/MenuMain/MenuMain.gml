/// @function
function MenuMain()
{
	var MenuOptions = array_length(MainList) - 2;
	var MenuPointer = array_length(MainList) - 1;
	
	// Exit if the current menu is inactive
	if !ActiveMenu[0]
	{
		exit;
	}
	
	// Navigate
	if Input.DownPress
	{
		MainList[MenuPointer]++;
	}
	if Input.UpPress
	{
		MainList[MenuPointer]--;
	}
	MainList[MenuPointer] = loop_value_range(MainList[MenuPointer], 0, MenuOptions + 1);
	
	show_debug_message(MainList[MainList[MenuPointer]][0]);
	//show_debug_message(MainList[MainList[MenuPointer]][1]);
	
	// Wait for the option select
	if !Input.APress
	{
		exit;
	}
	
	// Activate the select
	MainList[MainList[MenuPointer]][1] = true;
	
	// Disable current menu
	ActiveMenu[0] = false;
}