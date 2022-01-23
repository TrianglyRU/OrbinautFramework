function ObjPrisonMain()
{
	switch State 
	{
		// Waiting for player to press the button
		case 0:
		{
			// Do collision
			object_act_solid(true, true, true, false);
				
			// Check if the button has been pressed
			if ChildObject.State > 0
			{
				if Player.SuperState
				{
					// Restore stage music
					audio_bgm_play(TypePrimary, Stage.StageMusic);
					
					// Make player exit super form
					Player.SuperState = false;
				}
				Stage.IsFinished  = 1;
				Stage.TimeEnabled = false;
				Input.IgnoreInput = true;
				
				// Increment state
				State	  += 1;
				StateTimer = 60;
			}
		}	
		break;
			
		// Explode
		case 1: 
		{
			// Force player movement
			Input.Right = true;
			
			// Do collision
			object_act_solid(true, true, true, false);
				
			// Spawn explosions for 60 frames
			if (--StateTimer)
			{
				if !(--ExplosionTimer)
				{
					ExplosionTimer = irandom(32);
					instance_create(x + irandom(64) - 32, y + irandom(64) - 32, FireExplosion);
				}
				
				// Play sound each 8th frame
				if StateTimer mod 8 == 0 
				{ 
					audio_sfx_play(sfxExplosion, false);
				}
			}
			else
			{
				// Destroy button
				instance_destroy(ChildObject);
				
				// Spawn 8 animals
				var ThisObject = id;
				for (var i = 0; i < 8; i++)
				{
					var  NewObject = instance_create(x - 27 + 7 * i, y + 4, Animal);
					with NewObject
					{
						State = 2;
						Delay = 154 - i * 8;
							
						// Set depth
						object_set_depth(ThisObject, 0);
					}
				}	
				image_index = 1;
				
				// Increment state
				State	  += 1;
				StateTimer = 180;
			}
		}
		break;
			
		// Destroyed
		case 2:
		{
			if (--StateTimer)
			{ 
				// Spawn additional animal each 8th frame
				if StateTimer mod 8 == 0 
				{
					var ThisObject = id;
					TargetAnimal   = instance_create(x - 27 + irandom(7) * 7, y + 4, Animal);
					with TargetAnimal
					{
						State = 2;
						Delay = 12;
						
						// Set depth
						object_set_depth(ThisObject, 0);
					}
				}
			}
			
			// Start results event once target animal goes off-screen
			if Stage.IsFinished == 1 and instance_exists(TargetAnimal)
			{
				if !object_is_onscreen(TargetAnimal)
				{
					// Update flag
					Stage.IsFinished = 2;
				
					// Play resuts music
					audio_bgm_play(TypePrimary, ActClear);
				}
			}
		}
		break;
	}
	
	// Update stage boundaries
	if !Stage.IsBossfight
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