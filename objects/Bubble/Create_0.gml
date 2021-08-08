/// @description
// You can write your code in this editor
	
	BubbleType   = 0;			// 0 being small, 1 being medium, 2 being large
	Ysp          = -0.53125;
	WobbleOffset = 0;
	FromPlayer	 = 0;
	
	OriginPosX = x + (4 * Player.Facing) * FromPlayer;
	PosY	   = y;
	PosX	   = OriginPosX;
	
	object_set_depth(Player, true);