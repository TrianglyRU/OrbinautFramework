/// @description Main
// You can write your code in this editor
	
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
			if !(--Delay)
			{
				var NewObject = instance_create(x + irandom_range(-8, 7), y, Bubble);
			
				// Mark bubble as large if this is the cycle that should generate a large bubble
				if (Cycle mod AirFrequency) == 0 and BubbleID == LargeID 
				{
					with NewObject
					{
						Direction  = choose(FlipLeft, FlipRight);
						BubbleType = 2;
					
						object_set_triggerbox(-16, 16, -16, 16);
					
						animation_play(sprite_index, 15, 6); 
						image_index = 2;
					}
				}
			
				// Mark bubble as medium
				else if BubbleSet[ChosenSet][BubbleID] == 1
				{
					with NewObject
					{
						Direction  = choose(FlipLeft, FlipRight);
						BubbleType = 1;
					
						animation_play(sprite_index, 15, 6);
					
					}
				}
			
				// Mark bubble as small
				else with NewObject
				{
					Direction  = choose(FlipLeft, FlipRight);
					BubbleType = 0;
						
					animation_play(sprite_index, 15, 6);
				}
			
				// If no bubbles left to generate, return to idle state
				if !(--BubbleAmount)
				{
					Delay = AirBubbler_SetDelayTime();
					Cycle++;
					State--;	
				}
				else
				{
					// Set a delay until next bubble
					Delay = irandom_range(0, 31);
					BubbleID++;
				}
			}
		}
		break;
	}