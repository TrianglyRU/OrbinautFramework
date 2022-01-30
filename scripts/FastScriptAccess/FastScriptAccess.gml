function FastScriptAccess()
{
	/* Organised framework is cool and stuff, but sometimes you need
	a very quick access to the most important scripts. Well, here you go! */
	
	/* Click on the script and press F1 to open it */
	
	GameSetup();
	AudioSetup();
	BackgroundSetup();
	DiscordSetup();
	PaletteSetup();
	StageSetup();
	StagePaletteUpdate();
	
	MenuSetup();
	MenuManualProcess();
}