/// @function fade_check(state)
function fade_check(state)
{
	// Return FadeNone result if there is no palette controller for some reason
	if !instance_exists(Palette)
	{
		return state == FadeNone;
	}
	
	// Return check result
	switch state
	{
		case FadeNone:
			return Palette.FadeStep == 756;
		break;
		case FadeActive:
			return Palette.FadeStep < 756;
		break;
		case FadeMax:
			return Palette.FadeStep == 0;
		break;
	}	
}