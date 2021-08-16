function ObjTailsObjectDisplay()
{
	// Update tails display information
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);	
	depth		 = Player.DrawOrder + 1;
	image_xscale = Player.Facing;
	image_angle  = ResultAngle;

	// Draw tails on the screen
	draw_self();
}