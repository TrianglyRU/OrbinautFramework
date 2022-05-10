/// @description Main
// You can write your code in this editor
	
	switch State 
	{
		case 0:
		{		
			// Check if the button has been pressed
			if ButtonObj.State > 0
			{
				// Make player exit their super form
				if Player.SuperState
				{
					Player.SuperState = false;
					audio_bgm_play(AudioPrimary, Stage.StageMusic);					
				}
				
				Stage.TimeEnabled = false;
				Input.IgnoreInput = true;
				Stage.IsFinished  = 1;

				// Increment state
				State     += 1;
				StateTimer = 60;
			}
		}	
		break;
		case 1: 
		{
			// Force player movement
			Input.Right = true;

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
				// Clear solidbox
				object_set_solidbox(0, 0, false);
				
				// Destroy the button
				instance_destroy(ButtonObj);
				
				// Spawn 8 animals
				var ThisObject = id;
				for (var i = 0; i < 8; i++)
				{
					var  NewObject = instance_create(x - 27 + 7 * i, y + 4, Animal);
					with NewObject
					{
						State = 2;
						Delay = 154 - i * 8;
						
						// Update object depth
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
						
						// Update object depth
						object_set_depth(ThisObject, 0);
					}
				}
			}
			else if !object_is_onscreen(TargetAnimal)
			{
				audio_bgm_play(AudioPrimary, ActClear);
				
				// Increment stage & object state
				Stage.IsFinished = 2;
				State			+= 1;
			}
		}
		break;
	}
	
	// Do collision
	object_act_solid(true, true, true, false);

	// Update stage boundaries
	if !Stage.IsBossfight and x - floor(Player.PosX) < global.Width * 2
	{
		if floor(Player.PosX) >= Camera.ViewX + global.Width / 2
		{
			Stage.TargetLeftBoundary = Camera.ViewX;
		}
		else if State
		{
			Stage.TargetLeftBoundary = x - global.Width / 2;
		}
		Stage.TargetRightBoundary = x + global.Width / 2;
	}