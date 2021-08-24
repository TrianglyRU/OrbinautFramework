function PlayerDisplay()
{	
	// Update player
	x			 = floor(PosX);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	/* Fix one pixel offset when facing left. Comment this if you
	don't need that */
	if Facing == FlipLeft
	{
		x++;
	}
	
	// Draw player
	draw_self();
}