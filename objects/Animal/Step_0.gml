/// @description Insert description here
// You can write your code in this editor

	if Player.Death 
	{ 
		image_speed = 0; 
		vspeed = 0; 
		hspeed = 0; 
		gravity = 0; 
		exit; 
	}
	
	if FromCapsule = 1
	{ 
		vspeed = 0; 
		gravity = 0;
		if (Delay) Delay--;
		else
		{ 
			FromCapsule = 2; 
			vspeed = -4; 
			gravity = 0.21875; 
			depth--;
		}
	}
	
	if vspeed > 0 
	{
		if tile_meeting(bbox_left, bbox_bottom, LayerA) or tile_meeting(bbox_right, bbox_bottom, LayerA)
		{
	        vspeed = Ysp;
	        if !State 
			{	
	            image_xscale = FromCapsule ? choose(-1, 1) : -1;
				hspeed = Xsp * image_xscale;
				image_index = 1; 
	            State = 1;
	            switch sprite_index 
				{
	                case spr_flicky: Delay = 8; gravity = 0.09375; break;
	            }
	        }
	    }
	}
	
	if State 
	{
		switch sprite_index 
		{
			case spr_flicky: if (Delay) Delay-- else image_speed = 1; break;
			case spr_pocky : image_index = vspeed < 0 ? 1 : 2;		  break;
		}
	}