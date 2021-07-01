function MenuPointerHandle()
{
	// Set default position for pointer
	objLoadingIcon.x = Game.ResolutionWidth  / 2 - 110;
	objLoadingIcon.y = Game.ResolutionHeight / 2 - 21 + MenuOption * 15;
	
	// Adjust pointer position if needed
	switch MenuState
	{
		case InputConfig:
		{
			objLoadingIcon.y -= 30;
		}
		break;
		case DataSelect:
		{	
			objLoadingIcon.x -= 30;
		}
		break;
		case FrameworkConfig:
		{
			if MenuOption > 6
			{
				objLoadingIcon.y -= 7 * 15;
			}
		}	
		break;
	}
}