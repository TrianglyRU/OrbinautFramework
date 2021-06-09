/// @function
function MenuSettings()
{
	var MenuOptions = array_length(MainList) - 2;
	var MenuPointer = array_length(MainList) - 1;
	
	// Exit if the current menu is inactive
	if !ActiveMenu[4]
	{
		exit;
	}
	
	// Navigate
	if Input.DownPress
	{
		SettingsList[MenuPointer]++;
	}
	if Input.UpPress
	{
		SettingsList[MenuPointer]--;
	}
	SettingsList[MenuPointer] = loop_value_range(SettingsList[MenuPointer], 0, MenuOptions + 1);
	
	show_debug_message(SettingsList[SettingsList[MenuPointer]][0]);
	
	// Wait for the option select
	if !Input.APress
	{
		exit;
	}
	
	// Activate the select
	SettingsList[SettingsList[MenuPointer]][1] = true;
	
	// Disable current menu
	ActiveMenu[4] = false;
}