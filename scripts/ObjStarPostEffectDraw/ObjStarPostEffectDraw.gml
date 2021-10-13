function ObjStarPostEffectDraw()
{
	// Rotate and draw stars
	var Frame  = animate_sprite(4, 2);
	var Radius = Diameter >> 2;
	for (var i = 0; i < 4; i++)
	{
		draw_sprite(spr_obj_starpost_effect, Frame, floor(x + dcos(i * 90 + Timer * 14) * Radius), floor(y + dsin(i * 90 + Timer * 7) * Radius / 4));
	}
}