/// @description
// You can write your code in this editor
	
	// Framework Scripts
	#region Framework
	{
		// Call low priority music process script
		GameMusicLowProcess();
	
		// Call high priority music process script
		GameMusicHighProcess();
	}
	#endregion
	
	// Palette scripts
	#region Palette
	{
		// Call shift process script
		PaletteShiftProcess();
	
		// Call fade process script
		PaletteFadeProcess();
	}
	#endregion