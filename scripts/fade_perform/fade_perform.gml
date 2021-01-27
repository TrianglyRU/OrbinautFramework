/// @function screen_fade_perform(mode, colour, power)
function screen_fade_perform(mode, colour, power) 
{
	Game.FadeStep   = mode ? 0 : (colour == flash ? 1008 : 756); 
	Game.FadeMode   = mode; 
	Game.FadeColour = colour; 
	Game.FadePower  = power;
	Game.FadeTimer  = ceil((colour == flash ? 28 : 21) / power);
}