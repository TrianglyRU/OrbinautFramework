function PlayerDebugModeDisplay()
{
	if !DebugMode
	{
		return false;
	}
	
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
		case SpringRedVertical:      
			sprite_index = spr_obj_spring_red_v;	  
		break;
		case SpringRedHorizontal:   
			sprite_index = spr_obj_spring_red_h;    
		break;
		case SpringRedDiagonal:      
			sprite_index = spr_obj_spring_red_d;
		break;
	}
		
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