function PlayerDebugModeDisplay()
{
	if !DebugMode
	{
		return false;
	}
	else
	{
		// Switch between objects
		if Stage.DoUpdate
		{
			switch DebugList[DebugItem]
			{
				case Ring:
					sprite_index = spr_obj_ring;		  
				break;
				case ItemBox:	
					sprite_index = spr_obj_itembox;	  
				break;
				case SpikesVertical:	    
					sprite_index = spr_obj_spikesvertical;  
				break;
				case SpringYellowVertical:   
					sprite_index = spr_obj_spring_yellow_v; 
				break;
				case SpringYellowHorizontal:
					sprite_index = spr_obj_spring_yellow_h; 
				break;
				case SpringYellowDiagonal:   
					sprite_index = spr_obj_spring_yellow_d; 
				break;
				case SpringRedVertical:      
					sprite_index = spr_obj_spring_red_v;	  
				break;
				case SpringRedHorizontal:   
					sprite_index = spr_obj_spring_red_h;    
				break;
				case SpringRedDiagonal:      
					sprite_index = spr_obj_spring_yellow_d;
				break;
				case StarPost:				 
					sprite_index = spr_obj_starpost;		  
				break;
				case Animal:				 
					sprite_index = spr_obj_animal_flicky;   
				break;
				case Bridge:				 
					sprite_index = spr_obj_bridgelog_mqz;   
				break;
				case FloatingPlatform:		 
					sprite_index = spr_obj_platform_mqz;   
				break;
			}
		}
		
		// Update player
		x			 = floor(PosX);
		y			 = floor(PosY);
		image_xscale = Player.Facing;
		image_index  = 0;
		image_angle  = 360;
	
		// Draw player
		draw_self();
		
		// Return active debug mode
		return true;
	}
}