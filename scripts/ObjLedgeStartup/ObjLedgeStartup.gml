function ObjLedgeStartup()
{
	// Setup object
	switch object_index
	{
		case LedgeTSZ:
		{
			var Heightmap = 
			[
				81,81,81,81,
				82,82,82,82,82,82,
				83,83,83,83,83,83,
				84,84,84,84,84,84,84,
				85,85,85,85,85,85,
				86,86,86,86,86,86,
				87,87,87,87,87,87,87,
				88,88,88,88,
				89,89,89,89,89,89,89,89,
				90,90,90,90,90,90,90,
				91,91,91,91,91,91,
				92,92,92,92,92,92,
				93,93,93,93,93,93,93,
				94,94,94,94,94,94,
				95,95,95,95,95,95,
				96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96
			];
			var Solidbox = [];
		}
		break;
		default:
		{
			var Heightmap = [];
			var Solidbox  = [];
		}
	}
	
	TimeDelay = 0;
	State     = 0;
	OriginX   = floor(x - sprite_get_xoffset(sprite_index))
    OriginY   = floor(y - sprite_get_yoffset(sprite_index));
    Width     = ceil( abs(sprite_get_width(  sprite_index)) / 16) * 16;
    Height    = ceil( abs(sprite_get_height( sprite_index)) / 16) * 16;
   
	// Set object properties
	if array_length(Heightmap)
	{
		object_set_solidbox(array_length(Heightmap) div 2, sprite_get_height(sprite_index) div 2, Heightmap);
	}
	else if array_length(Solidbox)
	{
		object_set_solidbox(Solidbox[0], Solidbox[1], false);
	}
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
}