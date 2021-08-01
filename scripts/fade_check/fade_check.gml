/// @function fade_check(active|inactive)
function fade_check(check)
{
	// Exit if there is no palette contoller
	if !instance_exists(Palette)
	{
		return false;
	}
	
	// Return check result
	if  check and Palette.FadeStep != 756
	or !check and Palette.FadeStep == 756
	{
		return true;
	}
	else
	{
		return false;
	}
}