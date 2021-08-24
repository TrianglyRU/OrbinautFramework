function ObjBuzzbomberMain()
{
	// Move buzzbomber
	if (!Action or Action == 3) and Way 
	{ 
		x   += Direction * 4; 
		Way -= 4;
	}
		
	// "Search for target" state
	if !Action 
	{
		var PlayerX = floor(Player.PosX);
		var PlayerY = floor(Player.PosY);
 			
		// If spotted player nearby, shoot
		if abs(x - PlayerX) <= 96 and abs(y - PlayerY) <= 380 
		{
			if x < PlayerX and Direction = 1 or x > PlayerX and Direction = -1 
			{
				Action = 1;
				Delay  = 16;
				Way    = 500;
			}
		}
	}
	
	// "Fire" state
	else if Action == 2 
	{
		if BulletObject and !instance_exists(BulletObject)
		{
			BulletObject = noone;
		}
		else
		{
			switch Delay 
			{
				// Create bullet
				case 46:
				{		
					var BadnikDir = Direction;
					
					BulletObject = instance_create(x + 21 * Direction, y + 20, BuzzbomberBullet); 
					with BulletObject
					{
						image_xscale = BadnikDir;
						Xsp			 = 2 * BadnikDir;
						Ysp			 = 2;
						Timer		 = 17;
					}
				}
				break;
				
				// Release the bullet
				case 29:
				{
					BulletObject = noone;
				}
				break;
			}
		}
	}
		
	// Restore initial action
	if !Way 
	{
		Action     = 0;
		Way        = 500;
		Direction *= -1;
		
		image_xscale = Direction;
	}
		
	// Delay action
	if !(--Delay)
	{
		switch Action 
		{
			// Enter "fire" state
			case 1:
			{
				Action = 2;
				Delay = 60;
			}
			break;
			
			// Enter "after fire" state
			case 2: 
			{
				Action = 3;
			}
			break;
		}
	} 
	
	// Animate
	switch Action 
	{	
		// Set sprite
		case 0: 
		case 3:
			var Sprite = spr_obj_buzzbomber_fly;
		break;
		case 1: 
			var Sprite = spr_obj_buzzbomber_idle;
		break;
		case 2: 
			var Sprite = spr_obj_buzzbomber_fire;
		break;
	}
	animation_play(Sprite, 1, 0);
	
	// Act as badnik
	if object_act_enemy(EnemyBadnik)
	{
		// If buzzbomber has been destroyed, destroy its bullet if it is attached to it
		if BulletObject
		{
			instance_destroy(BulletObject);
		}
	}
}