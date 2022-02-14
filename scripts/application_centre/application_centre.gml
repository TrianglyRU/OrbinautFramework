/// @function application_centre(0 - x, 1 - y)
function application_centre(arg)
{
	switch arg
	{
		case 0: 
			return global.Width  / 2 + global.ScreenBuffer; 
		break;
		case 1: 
			return global.Height / 2;
		break;
	}
}

/// @function application_center(0 - x, 1 - y)
function application_center(arg)
{
	switch arg
	{
		case 0: 
			return global.Width  / 2 + global.ScreenBuffer; 
		break;
		case 1: 
			return global.Height / 2;
		break;
	}
}