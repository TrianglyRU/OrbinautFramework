/// @function fade_check(state)
function fade_check(state)
{
	// Return false if there is no palette controller for some reason
	if !instance_exists(Palette)
	{
		return false;
	}
	
	// Return check result
	switch state
	{
		case FadeActive:
			return Palette.FadeStep < 756;
		break;
		case FadeMax:
			return Palette.FadeStep == 0;
		break;
	}	
}