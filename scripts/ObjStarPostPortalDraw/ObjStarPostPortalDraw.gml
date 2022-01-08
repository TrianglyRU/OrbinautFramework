function ObjStarPostPortalDraw()
{	
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
		
		// Draw sprite
		draw_animated_sprite(spr_obj_starpost_portal, 8, false, floor(x + PosX), floor(y + PosY));
		
		/* 8 here is actually equals to 2 frames, because we call the function FOUR times its timer
		increased by 4 each frame instead of 1, so the duration should be 4 times greater as well 
		
		Obviously, this won't work correctly if there are two Star Posts nearby to each other. This
		can be solved by making the stars instances, or by using global time
		*/
	}
}