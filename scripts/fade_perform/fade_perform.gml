/// @function fade_perform(mode, colour, power)
function fade_perform(mode, colour, power) 
{
	if power > 1 power = 1;
	if power != 0
	{
		Game.FadeEnabled = true;
		Game.FadeStep   = mode ? 0 : (colour == flash ? 1008 : 756); 
		Game.FadeMode   = mode; 
		Game.FadeColour = colour; 
		Game.FadePower  = power;
		Game.FadeTimer  = ceil((colour == flash ? 28 : 21) / power);
	}
	else
	{
		Game.FadeEnabled = false;
	}
}