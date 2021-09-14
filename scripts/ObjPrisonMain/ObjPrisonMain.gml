function ObjPrisonMain()
{
	switch State 
	{
		// Waiting for player to press the button
		case 0:
		{
			// Do collision
			object_act_solid(true, true, true, false);
				
			// Check if button has been pressed
			if ChildObject.State
			{
				Timer     = 60;
				ExplDelay = irandom(32);
				
				Stage.TimeEnabled = false;
				Stage.IsFinished  = 1;
				
				// Disable super state
				if Player.SuperState
				{
					Player.SuperState = false;
				}
				audio_bgm_play(PriorityLow, Stage.StageMusic, other);
				
				// Increment state
				State++;
			}
		}	
		break;
			
		// Explode
		case 1: 
		{
			// Do collision
			object_act_solid(true, true, true, false);
				
			// Spawn explosions for 60 frames
			if Timer
			{
				if !(--ExplDelay)
				{
					ExplDelay = irandom(32);
					instance_create(x + irandom(64) - 32, y + irandom(64) - 32, FireExplosion);
				}
				
				// Play sound each 8th frame
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
				Timer       = 180;
				
				// Increment state
				State++;
			}
		}
		break;
			
		// Destroyed
		case 2:
		{
			// Disable collisions
			if Player.OnObject == id
			{
				Player.Grounded = false;
				Player.OnObject = false;
			}
				
			if Timer
			{ 
				// Spawn initial animals
				if Timer == 180
				{
					var ThisObject = id;
					for (var i = 0; i < 8; i++)
					{
						var  Object = instance_create(x - 27 + 7 * i, y + 4, Animal);
						with Object
						{
							State = 2;
							Delay = 154 - i * 8;
							
							object_set_depth(ThisObject, false);
						}
						TargetAnimal = Object;
					}
				}
				
				// Spawn additional animal each 8th frame
				if (--Timer) mod 8 == 0 
				{
					var  ThisObject = id;
					var  Object = instance_create(x - 27 + irandom(7) * 7, y + 4, Animal);
					with Object
					{
						State = 2;
						Delay = 12;
						
						object_set_depth(ThisObject, false);
					}
				}
			}
			
			// Start results event if target animal is off-screen
			if Stage.IsFinished == 1 and !instance_exists(Animal)
			{
				Stage.IsFinished = 3;
				audio_bgm_play(PriorityLow, ActClearMusic, noone);
			}
		}
		break;
	}
	
	// Update stage boundaries
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