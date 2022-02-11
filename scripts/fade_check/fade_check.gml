/// @function fade_check(fadeState)
function fade_check(fadeState)
{
	// Return false if there is no palette controller for some reason
	if !instance_exists(Palette)
	{
		return false;
	}
	
	// Return check result
	switch fadeState
	{
		case StateActive:
			return Palette.FadeStep < 756;
		break;
		case StateMax:
			return Palette.FadeStep == 0;
		break;
	}
	return false;
}