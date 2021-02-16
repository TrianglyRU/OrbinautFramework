function GameFadeShaderUpdate()
{	
	// Turn off fade if disabled
	if !Game.FadeEnabled 
	{ 
		Game.FadeStep = Game.FadeColour == flash ? 1008 : 756;
	} 
	
	// Update fade state every tick
	else 
	{
		if Game.FadeTimer > 0 
		{
			var Pow = 36 * Game.FadePower;
			Game.FadeTimer--; 
			Game.FadeStep = clamp(Game.FadeStep + (Game.FadeMode ? Pow : -Pow), 0, (Game.FadeColour == flash ? 1008 : 756));
		}
	}	
}