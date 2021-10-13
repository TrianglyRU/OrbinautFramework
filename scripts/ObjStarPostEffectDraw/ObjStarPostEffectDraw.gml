function ObjStarPostEffectDraw()
{	
	var Frame = animate_sprite(4, 2);
	var Radius = Diameter >> 2;
	var InitAngle = Timer * 12.65625;
	var temp4 = dsin(Timer * 2.8125) * 512 * 3;
	
	// Rotate and draw stars
	var PosX, PosY, CurAngle, SinX, SinY;
	for (var i = 0; i < 4; i++)
	{
		CurAngle = InitAngle + 90 * i;
		
		SinX = dsin(CurAngle) * 512;
		SinY = ((dcos(CurAngle) * 512) << 10) + SinX * temp4;
		SinX = SinX << 12;
		
		PosX = (SinX * Radius) >> 21;
		PosY = (SinY * Radius) >> 21;
		
		draw_sprite(spr_obj_starpost_effect, Frame, floor(x + PosX), floor(y + PosY));
	}
}