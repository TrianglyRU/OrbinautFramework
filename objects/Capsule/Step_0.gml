/// @description Insert description here
// You can write your code in this editor
	
	// Initialize
	if !Init
	{
		// Spawn button
		PartButton = instance_create_depth(x - 1, y - 38, depth + 1, CapsuleButton);
		Init	   = true;
	}
	else
	{
		switch State 
		{
			case 0:
			{
				if PartButton.Pressed
				{
					Timer = 60;
					State = 1;
					ExplDelay = irandom(32);
				}
			}
			break;
			case 1: 
			{
				if Timer
				{
					if (ExplDelay) ExplDelay--;
					else
					{
						ExplDelay = irandom(32);
						instance_create_depth(x + irandom(64) - 32, y + irandom(64) - 32, depth - 1, ExplosionFX);
					}
					// TODO: explosion sound
					/*
					if Timer != 60 and (60 - Timer) mod 8 = 0 { 
						audio_stop_sound(snd_explosion);
						audio_play_sound(snd_explosion, 0, 0);
					}
					*/
					Timer--;
				}
				else
				{
					object_set_collision(SolidNone);
					image_index = 1;
					State = 2;
					Timer = 180;
				}
			}
			break;
			case 2:
			{
				if Timer 
				{ 
					instance_destroy(PartButton);
					Timer--;
					if Timer mod 8 = 0 
					{
						with instance_create_depth(x - 27 + irandom(7) * 7, y + 8, depth, Animal) 
						{
							FromCapsule = true;
							Delay = 12;
						}
					}
				}
			}
			break;
		}
	}