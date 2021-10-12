function ObjBuzzbomberMain()
{
	switch State
	{
		// Move
		case 0:
		case 3:
		{
			// Turn after 128 frames
			if !(--Timer)
			{
				image_xscale *= -1;
				Timer	      = 127;
				State	      = 0;
			}
			else
			{
				// Search for the player nearby
				var PlayerX		= floor(Player.PosX);
				var FoundTarget = abs(x - PlayerX) <= 96 and sign(PlayerX - x) == sign(image_xscale);
				
				// Stop and fire, else move
				if !State and FoundTarget and object_is_onscreen(id)
				{
					State++;
					Timer = 29;
				}
				else
				{
					PosX += Xsp * image_xscale;	
				}
			}
		}
		break;
		
		// Idle, wait for 30 frames
		case 1:
		{
			if !(--Timer)
			{
				State++;
				Timer = 73;
			}
		}
		break;
		
		// Fire
		case 2:
		{
			// Wait for 60 + 14 frames
			if !(--Timer)
			{
				State++;
				Timer = 127;
			}
			
			// Create a projectile after 14 (+16) frames
			if Timer == 43
			{
				var  ThisObject = id;
				var  NewObject  = instance_create(x + 28 * image_xscale, y + 27, Projectile);
				with NewObject
				{					
					Grv			 = 0;
					Ysp          = 2;
					Xsp          = ThisObject.image_xscale * 2;
					image_xscale = ThisObject.image_xscale;
					sprite_index = spr_obj_projectile_buzzbomber;
				
					// Set object depth
					object_set_depth(ThisObject, false);
				}
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);
	
	// Act as badnik
	object_act_enemy(EnemyBadnik)
	
	// Animate
	switch State
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
}