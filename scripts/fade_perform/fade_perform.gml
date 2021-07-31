/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	// Clamp the power value
	power = clamp(power, 0, 255);
	var InstFade = power == 0;
	
	// Perform a fade
	Palette.FadeStep    = InstFade xor mode ? 0 : (colour == flash ? 1008 : 756); 
	Palette.FadeMode    = mode; 
	Palette.FadeColour  = colour; 
	Palette.FadePower   = power;
	Palette.FadeTimer   = InstFade ? 0 : ceil((colour == flash ? 28 : 21) / power);
}