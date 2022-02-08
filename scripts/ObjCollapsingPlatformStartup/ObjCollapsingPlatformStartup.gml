function ObjCollapsingPlatformStartup()
{
	// Setup object
	switch room
	{
		case Stage_TVZ:
		{
			var Heightmap = 
			[
				64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,
				65,65,65,65,65,65,65,65,65,65,65,
				66,66,66,66,66,66,
				67,67,67,67,67,
				68,68,68,68,
				69,69,69,
				70,70,70,
				71,71,71,
				72,72,72,
				73,73,
				74,74,
				75,75,
				76,76,
				77,77,
				78,78,
				79,79,79,79,79,79,
				80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
			];
			var Solidbox  = [];
			sprite_index  = spr_obj_collapsingplatform_tvz;
		}
		break;
		default:
		{
			var Heightmap = [];
			var Solidbox  = [];
			sprite_index  = spr_tempobject;
		}
		break;
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
	else
	{
		object_set_solidbox(Solidbox[0], Solidbox[1], false);
	}
	object_set_unload(TypePause);
	object_set_depth(Player, 0);
}