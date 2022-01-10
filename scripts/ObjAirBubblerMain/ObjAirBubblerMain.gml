function ObjAirBubblerMain()
{
	// Exit if above water
	if !Stage.WaterEnabled or y < Stage.WaterLevel
	{
		exit;
	}
	
	switch State
	{
		// Idle
		case 0:
		{
			// Once delay timer runs out, set generation properties
			if !(--Delay)
			{
				Delay		 = irandom_range(1, 32);			
				ChosenSet    = irandom_range(0, 3);
				BubbleAmount = irandom_range(1, 6);
				
				BubbleID = 0;
				LargeID  = irandom_range(0, BubbleAmount - 1);
				
				// Increment state
				State++;
			}
		}
		break;
		
		// Bubble making
		case 1:
		{
			// Generate a bubble
			var Object = instance_create(x + irandom_range(-8, 7), y, Bubble);
			
			// Mark bubble as large
			if BubbleID == LargeID and !(Cycle mod GenerationSpeed)
			{
				with Object
				{
					Direction  = FlipRight;
					BubbleType = 2;
					
					// Set object triggerbox
					object_set_triggerbox(-16, 16, -16, 16);
					
					// Set animation
					animation_play(sprite_index, 15, 2, 6);
				}
			}
			else 
			{
				// Mark bubble as small
				if !BubbleSet[ChosenSet][BubbleID]
				{
					with Object
					{
						Direction  = FlipRight;
						BubbleType = 0;
						
						// Set animation
						animation_play(sprite_index, 15, 0, 6);
					}
				}
			
				// Mark bubble as medium
				else
				{
					with Object
					{
						Direction  = FlipRight;
						BubbleType = 1;
						
						// Set animation
						animation_play(sprite_index, 15, 0, 6);
					}
				}
			}
			
			// Decrease amount of bubbles left to generate
			BubbleAmount--;
			Delay = irandom_range(0, 31);
			
			// Increment state
			State++;
		}
		break;
		
		// Continue to generate bubbles, or switch to idle state
		case 2:
		{
			if !BubbleAmount
			{
				Cycle++;
				Delay = irandom_range(128, 255);
				
				// Return to state 0
				State -= 2;
			}
			else if !(--Delay)
			{
				// Get next bubble to generate
				BubbleID++;
				
				// Return to state 1
				State--;
			}
		}
		break;
	}
}