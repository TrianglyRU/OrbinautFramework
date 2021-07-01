/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	// Clamp the power value
	power = clamp(power, 0, 255);
	
	// Perform a fade if the power is not zero
	if power != 0
	{
		Palette.FadeEnabled = true;
		Palette.FadeStep    = mode ? 0 : (colour == flash ? 1008 : 756); 
		Palette.FadeMode    = mode; 
		Palette.FadeColour  = colour; 
		Palette.FadePower   = power;
		Palette.FadeTimer   = ceil((colour == flash ? 28 : 21) / power);
	}
	
	// Perform instant fade if power is zero (disable it)
	else
	{
		Palette.FadeEnabled = false;
	}
}