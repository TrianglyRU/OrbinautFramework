/// @description Draw
// You can write your code in this editor

	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);
	image_angle  = VisualAngle;
	
	image_xscale = Player.Spinning and Player.Grounded ? sign(Player.Gsp) : sign(Player.Facing);
	visible		 = Player.visible;
	depth		 = Player.depth + 1;
	
	// Draw object
	draw_self();