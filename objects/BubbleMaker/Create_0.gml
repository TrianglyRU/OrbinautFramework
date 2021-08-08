/// @description
// You can write your code in this editor
	
	BubbleSet[0] = [0,0,0,0,1,0];
	BubbleSet[1] = [0,0,0,1,0,0];
	BubbleSet[2] = [1,0,1,0,0,0];
	BubbleSet[3] = [0,1,0,0,1,0];
	
	GenerationSet    = 0;
	GenerationID	 = 0;
	GenerationAmount = 0;
	
	LargeSpawned = false;
	
	Cycle	   = 0;
	CycleState = 0;
	CycleID	   = 0;
	CycleTimer = irandom_range(128, 255);
	
	switch GenerationSpeed
	{
		case "Fast":
			GenerationSpeed = 1;
		break;
		case "Medium":
			GenerationSpeed = 2;
		break;
		case "Slow":
			GenerationSpeed = 3;
		break;
	}
	