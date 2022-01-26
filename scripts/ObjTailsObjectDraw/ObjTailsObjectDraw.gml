function ObjTailsObjectDraw()
{
	// Update object
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);
	depth		 = Player.depth + 1;
	image_xscale = Player.Spinning and Player.Grounded ? sign(Player.Inertia) : sign(Player.Facing);
	image_angle  = VisualAngle;
	
	// Fix that one pixel offset when facing left
	if Player.Facing == FlipLeft
	{
		x++;
	}
	
	// Draw object
	draw_self();
}