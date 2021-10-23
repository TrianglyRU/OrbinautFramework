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
				case SpecialRing:
					sprite_index = spr_obj_specialring;
				break;
				case ItemBox:
					sprite_index = spr_obj_itembox;
				break;
				case SpikesVertical:	    
					sprite_index = spr_obj_spikesvertical;  
				break;
				case SpikesHorizontal:	    
					sprite_index = spr_obj_spikeshorizontal;  
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
					sprite_index = spr_obj_spring_red_d;
				break;
				case SpringRamp:
					sprite_index = spr_obj_springramp;
				break;
				case StarPost:				 
					sprite_index = spr_obj_starpost;		  
				break;
				case AirBubbler:				 
					sprite_index = spr_obj_airbubbler;		  
				break;
				case PushableBlock:				 
					sprite_index = spr_obj_pushableblock;		  
				break;
				case FloatingPlatform:		 
					sprite_index = spr_obj_platform_template;   
				break;
				case SwingingPlatform:		 
					sprite_index = spr_obj_swingplatform_editor;   
				break;
				case Bridge:				 
					sprite_index = spr_obj_bridge_editor;   
				break;
				case Animal:				 
					sprite_index = spr_obj_animal_flicky;   
				break;	
				case ClearPlate:				 
					sprite_index = spr_obj_signpost_start_sonic;   
				break;
				case EggPrison:				 
					sprite_index = spr_obj_eggprison;   
				break;
				case Player:
					sprite_index = spr_tempobject;
				break;
			}
		}
		
		// Update player
		x			 = floor(PosX);
		y			 = floor(PosY);
		image_index  = 0;
		image_xscale = Player.Facing;
		image_angle  = 360;
	
		// Draw player
		draw_self();
		
		// Return active debug mode
		return true;
	}
}