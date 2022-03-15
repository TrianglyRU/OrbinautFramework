/// @description Startup
// You can call your scripts in this editor
	
	TimeDelay = 0;
	State     = 0;
	OriginX   = floor(x - sprite_get_xoffset(sprite_index))
    OriginY   = floor(y - sprite_get_yoffset(sprite_index));
    Width     = ceil( abs(sprite_get_width(  sprite_index)) / 16) * 16;
    Height    = ceil( abs(sprite_get_height( sprite_index)) / 16) * 16;
   
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);