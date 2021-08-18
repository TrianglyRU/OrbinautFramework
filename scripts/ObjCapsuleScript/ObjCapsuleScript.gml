function ObjCapsuleScript()
{
	// Main code
	switch State 
	{
		// Waiting for player to press the button
		case 0:
		{
			// Do collision
			object_act_solid(true, true, true);
				
			// Check if button has been pressed
			if ChildObject.Pressed
			{
				Timer     = 60;
				State     = 1;
				ExplDelay = irandom(32);
				
				Stage.TimeEnabled = false;
				Stage.AllowPause  = false;
				Stage.IsFinished  = 1;
			
				if Player.SuperState
				{
					Player.SuperState = false;
				}
			}
		}	
		break;
			
		// Explode
		case 1: 
		{
			// Do collision
			object_act_solid(true, true, true);
				
			// Spawn explosions for 60 frames
			if Timer
			{
				if !(--ExplDelay)
				{
					ExplDelay = irandom(32);
					instance_create(x + irandom(64) - 32, y + irandom(64) - 32, FireExplosion);
				}
				
				if Timer != 60 and (60 - Timer) mod 8 == 0 
				{ 
					audio_sfx_play(sfxExplosion, false);
				}
				Timer--;
			}
				
			// Check if explode event has ended
			else
			{
				instance_destroy(ChildObject);
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
			object_act_solid(false, false, false);
				
			// Spawn animals for 180 frames
			if Timer 
			{ 
				if Timer == 180
				{
					var ThisObject = id;
					for (var i = 0; i < 8; i++)
					{
						var  Object = instance_create(x - 27 + 7 * i, y + 4, Animal);
						with Object
						{
							FromCapsule  = true;
							CapsuleDelay = 154 - i * 8;
							
							object_set_depth(ThisObject, false);
						}
					}
				}
				
				if (--Timer) mod 8 == 0 
				{
					var  ThisObject = id;
					var  Object = instance_create(x - 27 + irandom(7) * 7, y + 4, Animal);
					with Object
					{
						FromCapsule  = true;
						CapsuleDelay = 12;
						
						object_set_depth(ThisObject, false);
					}
				}
			}
			
			// Start results when no animals left
			if !instance_exists(Animal) and Stage.IsFinished == 1
			{
				Stage.IsFinished = 3;
				
				audio_bgm_play(PriorityLow, ActClearMusic, noone);
			}
		}
		break;
	}
	
	// Set boundaries
	if x - (Camera.ViewX + Game.Width) <= 128
	{
		if floor(Player.PosX) >= Camera.ViewX + Game.Width / 2
		{
			Stage.TargetLeftBoundary = Camera.ViewX;
		}
		else if State
		{
			Stage.TargetLeftBoundary = x - Game.Width / 2;
		}
		Stage.TargetRightBoundary = x + Game.Width / 2;
	}
}