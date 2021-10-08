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
	
	// Blink sprite
	if InvincibilityFrames and !Hurt
	{
		if !(InvincibilityFrames mod 4)
		{
			image_alpha = !image_alpha;
		}
	}
	else
	{
		image_alpha = 1;
	}
	
	// Draw player
	draw_self();
}