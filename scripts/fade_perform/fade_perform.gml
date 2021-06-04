/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	// Clamp the power value
	power = clamp(power, 0, 1);
	
	// Perform a fade if the power is not zero
	if power != 0
	{
		Game.FadeEnabled = true;
		Game.FadeStep    = mode ? 0 : (colour == flash ? 1008 : 756); 
		Game.FadeMode    = mode; 
		Game.FadeColour  = colour; 
		Game.FadePower   = power;
		Game.FadeTimer   = ceil((colour == flash ? 28 : 21) / power);
	}
	
	// Perform instant fade if power is zero (disable it)
	else
	{
		Game.FadeEnabled = false;
	}
}