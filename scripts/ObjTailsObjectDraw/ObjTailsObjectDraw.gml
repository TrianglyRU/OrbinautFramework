function ObjTailsObjectDraw()
{
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);
	visible		 = Player.visible;
	depth		 = Player.depth + 1;
	image_angle  = VisualAngle;
	image_xscale = Player.Spinning and Player.Grounded ? sign(Player.Inertia) : sign(Player.Facing);
	
	// Fix that one pixel offset when facing left
	if Player.Facing == FlipLeft
	{
		x++;
	}
	
	// Draw object
	draw_self();
}