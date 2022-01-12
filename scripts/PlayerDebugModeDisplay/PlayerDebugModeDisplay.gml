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
				case StarPost:				 
					sprite_index = spr_obj_starpost;		  
				break;
				case Bridge:
					sprite_index = spr_obj_bridge_editor;
				break;
				case FloatingPlatform:
					sprite_index = spr_obj_floatingplatform_editor;
				break;
				case CollapsingPlatform:
					sprite_index = spr_obj_collapsingplatform_editor;
				break;
				case SwingingPlatform:
					sprite_index = spr_obj_swingplatform_editor;
				break;
				case Buzzbomber:
					sprite_index = spr_obj_buzzbomber_idle;
				break;
				case Motobug:
					sprite_index = spr_obj_motobug;
				break;
				case Crabmeat:
					sprite_index = spr_obj_crabmeat_move;
				break;
				case Orbinaut:
					sprite_index = spr_obj_orbinaut;
				break;
				case PushableBlock:
					sprite_index = spr_obj_pushableblock;
				break;
				case Bumper:
					sprite_index = spr_obj_bumper;
				break;
				case Animal:				 
					sprite_index = spr_obj_animal_flicky;   
				break;	
				case ClearPanel:				 
					sprite_index = spr_obj_clearpanel_start_st;   
				break;
				case EggPrison:				 
					sprite_index = spr_obj_eggprison;   
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