/// @description Insert description here
// You can write your code in this editor
	
	object_set_solidbox(29, 8);
	object_set_range(RangeClose, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	JumpTimer = 0;
	
	// Unpressed
	ColMap1 = [0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,8,8,9,9,10,10,11,11,12,12,12,12,13,13,13,13,14,14,15,15,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16];
			   
	// Pressed	   
	ColMap2 = [0,1,1,2,2,3,3,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,5,5,5];
	