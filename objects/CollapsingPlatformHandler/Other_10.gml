/// @description Collapse Event
// You can write your code in this editor
	var Width = abs(sprite_width),
	Height = (ceil(sprite_height / 16) * 16)
	alarm[1] = Width / 16 * 4 + Height / 16 * 2;
	// Left
	if image_xscale = -1 
	{
		for(var i = 16; i <= Width; i += 16) 
		{
			for(var j = Height - 16; j >= 0; j -= 16) 
			{
				// Create Parts
				var Part = instance_create_depth(x - Width + i, (y - sprite_yoffset) + j, depth - 1, CollapsingPlatformTile);
				with(Part) {
					// Set position variables
					PartX = Width - i;
					PartY = j;
					
					// Set sprite and direction
					sprite_index = other.sprite_index;                      
					image_xscale = other.image_xscale;
					alarm[0] = i / 16 * 4 + j / 16 * 2;
				}	
			}
		}
	}

	// Right
	if image_xscale = 1 
	{
		for(var i = Width - 16; i >= 0; i -= 16) 
		{
			for(var j = Height - 16; j >= 0; j -= 16) 
			{            
				
				// Create Parts
				var Part = instance_create_depth(x + i, (y - sprite_yoffset) + j, depth + 1, CollapsePlatformPart);
				with(Part) {
					// Set position variables
					PartX = i;
					PartY = j;
					
					// Set sprite and direction
					sprite_index = other.sprite_index;
					image_xscale = other.image_xscale;
					alarm[0] = abs(Width - i) / 16 * 4 + abs(Height - j) / 16 * 2;
				}
			}
		}
	}