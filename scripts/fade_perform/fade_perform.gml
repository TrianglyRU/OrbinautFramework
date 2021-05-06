/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	// Limit power value in range of [0, 1]
	power = clamp(power, 0, 1);
	
	// Perform fade if power is greater than 0
	if power != 0
	{
		Game.FadeEnabled = true;
		Game.FadeStep    = mode ? 0 : (colour == flash ? 1008 : 756); 
		Game.FadeMode    = mode; 
		Game.FadeColour  = colour; 
		Game.FadePower   = power;
		Game.FadeTimer   = ceil((colour == flash ? 28 : 21) / power);
	}
	
	// Perform instant fade if power is 0 (basically just disable it)
	else
	{
		Game.FadeEnabled = false;
	}
}