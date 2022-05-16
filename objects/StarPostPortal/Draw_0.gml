/// @description Draw
// You can write your code in this editor
	
	var Temp1 = Diameter >> 2;
	var Temp2 = Timer * 12.65625;
	var Temp3 = dsin(Timer * 2.8125) * 512 * 3;
	
	// Math time!
	for (var i = 0; i < 4; i++)
	{
		var Temp4 = Temp2 + 90 * i;
		
		var X =   dsin(Temp4) * 512;
		var Y = ((dcos(Temp4) * 512) << 10) + X * Temp3;
		var X = X << 12;
		
		var PosX = (X * Temp1) >> 21;
		var PosY = (Y * Temp1) >> 21;
		
		// Draw sprite
		draw_anisprite(spr_obj_starpost_portal, 8, false, round(x + PosX), round(y + PosY));

		/* 8 here is actually equals to 2, because we call the function FOUR times per frame so the timer
		is increased by 4 instead of 1, and therefore the duration should be 4 times greater as well 
		
		Obviously, this won't work correctly if there are two Star Posts nearby to each other. This
		can be solved by making the stars as instances or by using the global animation timer
		*/
	}
	