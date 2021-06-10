/// @function
function BackgroundParallax()
{
	for (var i = 0; i < array_length(BackgroundObject); i++)
	{
		with BackgroundObject[i]
		{
			bg_objectisVariableialize();
			bg_object_parallax(0, 0, 0,    0,    0, 0, 0,   167,		   0, 0);
			bg_object_parallax(0, 0, 0.15, 0.01, 0, 0, 168, sprite_height, 2, 0.3);
			bg_object_update();
		}
	}
}