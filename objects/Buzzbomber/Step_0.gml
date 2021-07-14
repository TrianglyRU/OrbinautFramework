/// @description Insert description here
// You can write your code in this editor
	
	if !(x > Screen.CameraX + Screen.Width + 220 
	or x < Screen.CameraX - 220) and visible 
	{	
		// Change Position
		if (!Action or Action = 3) and Way 
		{ 
			x += Dir * 4; 
			Way -= 4;
		}
		
		// Action Fly
		if !Action 
		{
			var PosX = Player.PosX // Player position
			
			// Change action to fire
			if abs(x - PosX) <= 88 and abs(y - Player.PosY) <= 380 
			{
				if x < PosX and Dir = 1 or x > PosX and Dir = -1 
				{
					Action = 1;
					Delay = 16;
					Way = 500;
				}
			}
		}
	
		if Action = 2 
		{
			var BadnikDir = Dir;
			switch Delay 
			{
				case 46: 
					Bullet = instance_create_depth(x + 26 * BadnikDir, y + 28, depth - 1, BuzzBullet); 
					Bullet.image_xscale = BadnikDir; 
				break;
				case 38: 
					Bullet.image_index = 1;
				break;
				case 29: 
					with Bullet 
					{ 
						image_index = 2; 
						image_speed = 1; 
						hspeed = 2 * BadnikDir; 
						vspeed = 2;
					} 
					Bullet = noone; 
				break;
			}
		}
		
		// Action Restore
		if !Way 
		{
			Way = 500;
			Dir *= -1;
			image_xscale = Dir;
			Action = 0;
		}
		
		// Action Delay
		if !Delay 
		{
			switch Action 
			{
				case 1: Action = 2; Delay = 60 break;
				case 2: Action = 3 break;
			}
		} 
		else 
		{
			Delay--;
		}
	
		// Animation	
		switch Action {		
				case 0: sprite_index = spr_badnik_buzzbomber_fly  break
				case 1: sprite_index = spr_badnik_buzzbomber_idle break
				case 2: sprite_index = spr_badnik_buzzbomber_fire break
				case 3: sprite_index = spr_badnik_buzzbomber_fly  break
		}
		
		// Check for hitbox overlap
		if object_player_overlap(CollisionHitbox)
		{
			// Damage player or be destroyed
			object_act_badnik(true, false);
		}
	} 
	else 
	{ 
		if Bullet
		{ 
			instance_destroy(Bullet);
		}
		Action = 0; 
		x = InitX; 
		Way = 500; 
		image_xscale = InitDir;
		Dir			 = InitDir;
		visible = (InitX > Screen.CameraX + Screen.Width + 220 or InitX < Screen.CameraX - 220);
	}