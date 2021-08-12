/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	// Exit if there is no palette contoller
	if !instance_exists(Palette)
	{
		exit;
	}
	
	// Clamp the power value
	power = clamp(floor(power * 36), 0, 756);
	var InstFade = power == 0;
	
	// Perform a fade
	Palette.FadeStep    = InstFade xor mode ? 0 : 756; 
	Palette.FadeMode    = mode; 
	Palette.FadeColour  = colour;
	Palette.FadePower   = power;
}