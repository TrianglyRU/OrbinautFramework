/// @description Main
// You can write your code in this editor

	// Act as badnik and exit if it was destroyed
	if object_act_enemy(EnemyBadnik)
	{
		return;
	}
	
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
				if !State and FoundTarget
				{
					if object_is_onscreen(id)
					{
						State++;
						Timer = 29;
					
						// Set animation
						animation_play(spr_obj_buzzbomber_idle, 1, 0);
					}
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
				
				// Set animation
				animation_play(spr_obj_buzzbomber_fire, 1, 0);
			}
		}
		break;
		
		// Fire
		case 2:
		{
			if !(--Timer)
			{
				State++;
				Timer = 127;
				
				// Set animation
				animation_play(spr_obj_buzzbomber_fly, 1, 0);
			}
			
			// Create a projectile
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
					object_set_depth(ThisObject, 0);
				}
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);