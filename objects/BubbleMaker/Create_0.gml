/// @description
// You can write your code in this editor
	
	BubbleAmount = 0;
	BubbleID	 = 0;
	LargeID		 = 0;
	LargeSpawned = 0;	
	CycleNumber	 = 0;
	CycleState   = 0;
	CycleTimer   = 0;
	ChosenSet    = 0;
	BubbleSet	 = [];
	
	BubbleSet[0] = [0,0,0,0,1,0];
	BubbleSet[1] = [0,0,0,1,0,0];
	BubbleSet[2] = [1,0,1,0,0,0];
	BubbleSet[3] = [0,1,0,0,1,0];
	
	CycleNumber = 1;
	CycleTimer  = irandom_range(128, 255);
	
	object_set_range(RangeClose, TypeUnload);
	