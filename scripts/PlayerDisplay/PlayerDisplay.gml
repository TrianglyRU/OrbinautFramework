function PlayerDisplay()
{	
	// Update player
	x			 = floor(PosX);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Fix that one pixel offset when facing left
	if Facing == FlipLeft
	{
		x++;
	}
	
	// Draw player
	draw_self();
}