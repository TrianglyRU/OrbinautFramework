function GameShaderPaletteSetLoad()
{	
	switch room 
	{	
		// Load palette set for Moonlight Base
		case MBZ:
		case MBZ2:
		{
			Game.PaletteSet = pal_MoonlightBaseZone; 
		}
		break;
	}
}