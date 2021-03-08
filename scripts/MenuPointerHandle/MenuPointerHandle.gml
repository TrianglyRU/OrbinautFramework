function MenuPointerHandle()
{
	// Set Sonic
	objLoadingIcon.x = Game.ResolutionWidth  / 2 - 110;
	objLoadingIcon.y = Game.ResolutionHeight / 2 - 21 + MenuOption * 15;
	if (MenuState = InputConfig) objLoadingIcon.y -= 30;
	if (MenuState = DataSelect)  objLoadingIcon.x -= 30;
}