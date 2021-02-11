function ObjLamppostSpin()
{	
	// Draw us
	draw_self();
	
	// Draw rotating lamp sprite separately for spin event
	if Active and Angle < 900
	{
		draw_sprite(spr_obj_lamppost_lamp, 0, x + dsin(Angle) * 12, y + dcos(Angle) * 12 - 12);
	}
}