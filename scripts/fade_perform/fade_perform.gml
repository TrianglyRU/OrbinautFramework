/// @function fade_perform(mode,colour,power)
function fade_perform(mode,colour,power) 
{
	// Clamp the power value
	power = clamp(floor(power * 36), 0, 756);
	
	// If power is set to 0, perform instant fade
	var InstantFade = power == 0;
	
	// Perform a fade
	Palette.FadeStep   = InstantFade xor mode ? 0 : 756; 
	Palette.FadeMode   = mode; 
	Palette.FadeColour = colour;
	Palette.FadePower  = power;
}