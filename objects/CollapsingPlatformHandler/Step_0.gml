/// @description Collision
// You can write your code in this editor

	//if (Player.actDeath) { image_speed = 0; exit; }
	
	var Id = id;
	
	if keyboard_check_pressed(ord("F")) and !CLG_Lollapse {
		//FLR_Llarm[0] = 7 // Collapsing timer
		with Id event_perform(ev_alarm, 0);
		CLG_Lollapse = 1;
	}
	/*
	with SolidboxB 
	{
		if Player.OnObject and Player.Ysp >= 0 and place_meeting(x, y + 8, Id) 
		{
			if !CLG_Lollapse {
				//FLR_Llarm[0] = 7 // Collapsing timer
				with Id event_perform(ev_alarm, 0);
				CLG_Lollapse = 1;
			}
		}
	}
	*/