function ObjAirBubblerMain()
{
	if !Stage.WaterEnabled or y < Stage.WaterLevel
	{
		return;
	}
	
	switch State
	{
		// Idle
		case 0:
		{
			if !(--Delay)
			{
				// Once delay timer runs out, set generation properties
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
		
		// Bubble Generation
		case 1:
		{
			var NewObject = instance_create(x + irandom_range(-8, 7), y, Bubble);
			
			// Mark bubble as large
			if BubbleID == LargeID and !(Cycle mod GenerationSpeed)
			{
				with NewObject
				{
					Direction  = choose(FlipLeft, FlipRight);
					BubbleType = 2;
					
					object_set_triggerbox(-16, 16, -16, 16);
					
					animation_play(sprite_index, 15, 6); image_index = 2;
				}
			}
			
			// Mark bubble as small
			else if !BubbleSet[ChosenSet][BubbleID]
			{
				with NewObject
				{
					Direction  = choose(FlipLeft, FlipRight);
					BubbleType = 0;
						
					animation_play(sprite_index, 15, 6);
				}
			}
			
			// Mark bubble as medium
			else with NewObject
			{
				Direction  = choose(FlipLeft, FlipRight);
				BubbleType = 1;
					
				animation_play(sprite_index, 15, 6);
			}
			
			// Decrease amount of bubbles left
			BubbleAmount--;
			Delay = irandom_range(0, 31);
			
			// Increment state
			State++;
		}
		break;
		
		// Continue or Switch Back
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
				BubbleID++;
				
				// Return to state 1
				State--;
			}
		}
		break;
	}
}