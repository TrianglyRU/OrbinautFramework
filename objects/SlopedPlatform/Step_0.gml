/// @description Scripts Event
// You can call your scripts in this editor
	
	object_act_solid(false, true, false, ColMap);
	
	if CollapseState
	{
		if CollapseState == 1 
		{
			if Player.OnObject == id
			{
				DestroyTimer = Width / PartW * 4 + Height / PartH * 2;
				var ID = id;
				if image_xscale
				{
					for (var i = Width - PartW; i >= 0; i -= PartW)
					{
						for (var j = Height - PartH; j >= 0; j -= PartH) 
						{
							var Time = abs(Width - i) / PartW * 4 + abs(Height - j) / PartH * 2;
							var Part = instance_create_depth(PosX + i, PosY + j, depth - 1, CollapsePlatformPart);
							with Part
							{
								PartX = i;
								PartY = j;
								sprite_index = ID.sprite_index;
								image_xscale = ID.image_xscale;
								Timer = Time;
							}
						}
					}
				}
				else
				{
					for (var i = PartW; i <= Width; i += PartW) 
					{
						for (var j = Height - PartH; j >= 0; j -= PartH) 
						{
							var Time = i / PartW * 4 + abs(Height - j) / PartH * 2;
							var Part = instance_create_depth(PosX + i, PosY + j, depth - 1, CollapsePlatformPart);
							with Part
							{
								PartX = ID.Width - i;
								PartY = j;
								sprite_index = ID.sprite_index;                      
								image_xscale = ID.image_xscale;
								Timer = Time;
							}
						}
					}
				}
				CollapseState = 2;
			}
		}
		else if DestroyTimer
		{
			DestroyTimer--;
		}
		else
		{
			instance_destroy();
			Player.OnObject = false;
		}
	}