/// @description
// You can write your code in this editor
	
	var bubSpawn = "-";
	
	// Timer stuff
	CycleTimer--;
	if !CycleTimer
	{
		// Idle period
		if CycleState mod 2 == 0
		{
			CycleState++;
			CycleTimer		 = irandom_range(1, 32);
			GenerationAmount = irandom_range(1, 6);
			GenerationSet    = irandom_range(0, 3);
			GenerationID     = 0;	
		}
	
		// Making period
		else
		{
			var GeneratedBubble = instance_create(x + irandom_range(-8, 7), y, Bubble);
			
			var LargeChance = irandom_range(0, 3);
			if CycleID mod GenerationSpeed == 0 and (!LargeChance and !LargeSpawned or CycleState == 5 and !LargeSpawned)
			{
				// create large bubble
				with GeneratedBubble
				{
					BubbleType = 2;
				}
				LargeSpawned = true;
			}
			else
			{
				if !BubbleSet[GenerationSet][GenerationID]
				{
					var bubSpawn = "Small!";
					// create small bubble
					with GeneratedBubble
					{
						BubbleType = 0;
					}
				}
				else
				{
					var bubSpawn = "Medium!";
					// create medium bubble
					with GeneratedBubble
					{
						BubbleType = 1;
					}
				}
			}
			
			// Continue to spawn bubbles, or switch to idle state
			GenerationAmount--
			if !GenerationAmount
			{
				if CycleState == 5
				{
					CycleState = 0;
					CycleID++;
					LargeSpawned = false;
				}
				else
				{
					CycleState++;
				}
				CycleTimer = irandom_range(129, 256);
			}
			else
			{
				GenerationID++;
				CycleTimer = irandom_range(1, 32);
			}
		}
	}

	var cycleState = CycleState mod 2 == 0 ? "IDLE" : "MAKING";
	
	/*show_debug_message("Timer:		    " + string(CycleTimer));
	show_debug_message("State:		    " + cycleState);
	show_debug_message("Cycle ID:    " + string(CycleID));
	show_debug_message("Cycle State:    " + string(CycleState));
	show_debug_message("Large Possible: " + string(CycleID mod GenerationSpeed == 0));
	show_debug_message("Large Spawned:  " + string(LargeSpawned));
	
	if CycleState mod 2 != 0
	{
		show_debug_message("Generation Set: " + string(GenerationSet));
		show_debug_message("Bubble Index:	" + string(GenerationID));
		show_debug_message("Bubble Type:    " + bubSpawn);
		show_debug_message("Bubbles Left:   " + string(GenerationAmount));
	}
	else
	{
		show_debug_message("Generation Set: " + "-");
		show_debug_message("Bubble Index:	" + "-");
		show_debug_message("Bubble Type:    " + "-");
		show_debug_message("Bubbles Left:   " + "-");
	}*/