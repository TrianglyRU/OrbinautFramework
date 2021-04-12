function ObjCapsuleScript()
{
	// Initialize
	if !Init
	{
		// Spawn button
		PartButton = instance_create_depth(x - 1, y - 38, depth + 1, CapsuleButton);
		Init	   = true;
	}
	
	// Main code
	else
	{
		switch State 
		{
			// Waiting for player to press the button
			case 0:
			{
				// Do collision
				object_do_player_collision(SolidAll, false);
				
				// Check if button has been pressed
				if PartButton.Pressed
				{
					Timer     = 60;
					State     = 1;
					ExplDelay = irandom(32);
				}
			}	
			break;
			
			// Explode
			case 1: 
			{
				// Do collision
				object_do_player_collision(SolidAll, false);
				
				// Spawn explosions for 60 frames
				if Timer
				{
					if ExplDelay
					{
						ExplDelay--;
					}
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
				
				// Check if explode event has ended
				else
				{
					instance_destroy(PartButton);
					image_index = 1;
					State       = 2;
					Timer       = 180;
				}
			}
			break;
			
			// Destroyed
			case 2:
			{
				// Disable collisions
				object_do_player_collision(SolidNone, false);
				
				// Spawn animals for 180 frames
				if Timer 
				{ 
					Timer--;
					if Timer mod 8 == 0 
					{
						with instance_create_depth(x - 27 + irandom(7) * 7, y + 8, depth, Animal) 
						{
							FromCapsule = true;
							Delay       = 12;
						}
					}
				}
			}
			break;
		}
	}
}