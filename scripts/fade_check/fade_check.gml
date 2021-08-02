/// @function fade_check(fade_state)
function fade_check(fade_state)
{
	// Exit if there is no palette contoller
	if !instance_exists(Palette)
	{
		return false;
	}
	
	// Return result check
	switch fade_state
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