function PlayerDisplay()
{	
	x			 = floor(PosX);
	y		     = floor(PosY);
	image_angle  = VisualAngle;
	
	// Update xscale once animation frame updates
	if Obj_AnimTimer + 1 == Obj_AnimDuration or Obj_AnimTimer <= 1
	{
		image_xscale = Facing;
	}
	
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