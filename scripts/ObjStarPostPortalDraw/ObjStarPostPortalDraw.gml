function ObjStarPostPortalDraw()
{	
	// Define frame to display
	var Frame = animate_sprite(4, 2);
	
	// Set temp values
	var Temp1 = Diameter >> 2;
	var Temp2 = Timer * 12.65625;
	var Temp3 = dsin(Timer * 2.8125) * 512 * 3;
	
	// Rotate and draw stars
	for (var i = 0; i < 4; i++)
	{
		var Temp4 = Temp2 + 90 * i;
		
		var SinX = dsin(Temp4) * 512;
		var SinY = ((dcos(Temp4) * 512) << 10) + SinX * Temp3;
		var SinX = SinX << 12;
		
		var PosX = (SinX * Temp1) >> 21;
		var PosY = (SinY * Temp1) >> 21;
		
		// Draw
		draw_sprite(spr_obj_starpost_portal, Frame, floor(x + PosX), floor(y + PosY));
	}
}