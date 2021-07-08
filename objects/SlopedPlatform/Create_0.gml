/// @description Scripts Event
// You can call your scripts in this editor
	
	object_set_solidbox(56, 48);
	if CollapseState
	{
		Timer  = 0;
		PosX   = floor(x - objXRadiusSolid);
		PosY   = floor(y - objYRadiusSolid);
		Width  = ceil(abs(sprite_width)  / PartW) * PartW;
		Height = ceil(abs(sprite_height) / PartH) * PartH;
		Dir	   = sprite_width >= 0 ? 1 : -1;
		DestroyTimer = 0;
	}
	ColMap = [48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,
			  47,47,47,47,47,47,
			  46,46,46,46,46,46,
			  45,45,45,45,45,45,45,
			  44,44,44,44,44,44,
			  43,43,43,43,43,43,
			  42,42,42,42,42,42,42,
			  41,41,41,41,41,41,41,41,
			  40,40,40,40,
			  39,39,39,39,39,39,39,
			  38,38,38,38,38,38,
			  37,37,37,37,37,37,
			  36,36,36,36,36,36,36,
			  35,35,35,35,35,35,
			  34,34,34,34,34,34,
			  33,33,33,33]