function ObjStarPostDraw()
{	
	// Draw starpost
	draw_self();
	
	// Draw lamp
	if State == 2 and Angle < 900
	{
		draw_sprite(spr_obj_starpost_lamp, 0, x + dsin(Angle) * 12, y + dcos(Angle) * 12 - 12);
	}
}