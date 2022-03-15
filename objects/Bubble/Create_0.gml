/// @description Startup
// You can write your code in this editor
	
	PosX		 =  x;
	PosY		 =  y;
	Ysp			 = -0.53125;
	BubbleType   =  0;
	WobbleOffset =  0;
	Collected	 =  0;
	FinalX		 =  0;
	Direction    =  0;
	
	// Set object properties
	object_set_unload(FlagDelete);
	object_set_depth(Player, 1);