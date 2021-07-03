function ObjStarPostDraw()
{	
	draw_self();
	
	if Active and Angle < 900
	{
		draw_sprite(spr_obj_starpost_lamp, 0, x + dsin(Angle) * 12, y + dcos(Angle) * 12 - 12);
	}
}