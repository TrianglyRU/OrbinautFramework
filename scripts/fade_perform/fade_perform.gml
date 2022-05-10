/// @function fade_perform(fadeMode,fadeBlend,speed)
function fade_perform(fadeMode,fadeBlend,speed) 
{
    // Clamp the speed value
	speed = clamp(floor(speed * 36), 0, 756);
    
    // If speed is set to 0, perform instant fade
    var InstantFade = speed == 0;
    
    // Perform fade
    if InstantFade or !(Palette.FadeValue mod 756)
    {
        Palette.FadeValue = InstantFade xor fadeMode ? 0 : 756; 
        Palette.FadeMode = fadeMode; 
    }
    Palette.FadeBlend = fadeBlend;
    Palette.FadeSpeed = speed;
}