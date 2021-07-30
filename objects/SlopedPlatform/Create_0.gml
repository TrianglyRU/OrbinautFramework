/// @description Scripts Event
// You can call your scripts in this editor
	
	object_set_solidbox(56, 48);
	object_set_range(RangeClose, false);
	
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
	ColMap = [96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,
			  95,95,95,95,95,95,
			  94,94,94,94,94,94,
			  93,93,93,93,93,93,93,
			  92,92,92,92,92,92,
			  91,91,91,91,91,91,
			  90,90,90,90,90,90,90,
			  89,89,89,89,89,89,89,89,
			  88,88,88,88,
			  87,87,87,87,87,87,87,
			  86,86,86,86,86,86,
			  85,85,85,85,85,85,
			  84,84,84,84,84,84,84,
			  83,83,83,83,83,83,
			  82,82,82,82,82,82,
			  81,81,81,81];