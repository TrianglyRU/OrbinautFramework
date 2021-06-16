function PlayerDebugModeDisplay()
{
	// Switch between objects
	switch DebugList[DebugItem]
	{
		// General
		case Ring:			   animation_set_frame(spr_obj_ring, 1);			break;
		case SpikesVertical:   animation_set_frame(spr_obj_spikesvertical, 1);  break;
		case SpringVertical:   animation_set_frame(spr_obj_spring_yellow_v, 1); break;
		case SpringHorizontal: animation_set_frame(spr_obj_spring_yellow_h, 1); break;
		case Lamppost:		   animation_set_frame(spr_obj_lamppost, 1);		break;
		case Animal:		   animation_set_frame(spr_obj_animal_flicky, 1);   break;
		case Bridge:		   animation_set_frame(spr_obj_bridgelog_mqz, 1);   break;
		case FloatingPlatform: animation_set_frame(spr_obj_platform_mqz, 1);    break;
	}
	
	// Update character display information
	x			 = floor(PosX);
	y			 = floor(PosY);
	image_xscale = 1;
	image_angle  = 360;
	
	// Draw player on the screen
	draw_self();
}