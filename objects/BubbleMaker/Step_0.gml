/// @description
// You can write your code in this editor
	
	// Exit if above water
	if !Stage.WaterEnabled or y < Stage.WaterLevel
	{
		exit;
	}
	
	// Play animation
	animation_play(sprite_index, 16, 1);
	
	// Count down the timer
	if --CycleTimer
	{
		exit;
	}
	
	// Define generation settings if in idle state
	if !CycleState
	{
		CycleState++;
			
		CycleTimer   = irandom_range(1, 32);			
		ChosenSet    = irandom_range(0, 3);
		BubbleAmount = irandom_range(1, 6);
			
		BubbleID = 0;
		LargeID  = irandom_range(0, BubbleAmount - 1);
	}
		
	// Making state
	else
	{
		// Generate a bubble
		var GeneratedBubble = instance_create(x + irandom_range(-8, 7), y, Bubble);
			
		// Mark bubble as large
		if BubbleID == LargeID and !(CycleNumber mod GenerationSpeed)
		{
			with GeneratedBubble
			{
				BubbleType = 2;
				object_set_triggerbox(-16, 16, -16, 16);
			}
		}
			
		// Mark bubble as small
		else 
		{
			if !BubbleSet[ChosenSet][BubbleID]
			{
				with GeneratedBubble
				{
					BubbleType = 0;
				}
			}
			
			// Mark bubble as medium
			else
			{
				with GeneratedBubble
				{
					BubbleType = 1;
				}
			}
		}
			
		// Continue to generate bubbles, or switch to idle state
		if !(--BubbleAmount)
		{
			CycleState--;
			CycleNumber++;
			CycleTimer = irandom_range(129, 256);
		}
		else
		{
			BubbleID++;
			CycleTimer = irandom_range(1, 32);
		}
	}