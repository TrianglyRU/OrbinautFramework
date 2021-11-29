function ObjCollapsingLedgeStartup()
{
	// Setup object
	switch room
	{
		case Stage_TZ:
		{
			var HeightMap = 
			[
				64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,65,65,65,65,66,66,66,66,67,67,67,67,68,68,68,68,
				69,69,69,69,70,70,70,70,71,71,71,71,72,72,72,72,73,73,73,73,74,74,74,74,75,75,75,75,76,76,76,76,
				77,77,77,77,78,78,78,78,79,79,79,79,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
			];
			sprite_index = spr_obj_collapsingledge_editor;
		}
		break;
		default:
		{
			var HeightMap = []; 
			sprite_index  = spr_tempobject;
		}
		break;
	}
	
	// Set variables
	State     = 0;
	TimeDelay = 8;
	OriginX   = floor(x - array_length(HeightMap) / 2);
    OriginY   = floor(y - sprite_get_yoffset(sprite_index));
    Width     = ceil(abs(sprite_get_width(sprite_index))  / 16) * 16;
    Height    = ceil(abs(sprite_get_height(sprite_index)) / 16) * 16;
   
	// Set object solidbox
	if array_length(HeightMap)
	{
		object_set_solidbox(array_length(HeightMap) / 2, sprite_get_height(sprite_index) / 2, HeightMap);
	}
	
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypePause);
}