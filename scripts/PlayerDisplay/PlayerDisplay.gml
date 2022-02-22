function PlayerDisplay()
{	
	x			 = floor(PosX);
	y		     = floor(PosY);
	image_angle  = VisualAngle;
	
	// If spinning, update xscale once animation frame updates (always applied in Sonic 1)
	if Animation != AnimSpin or Obj_AnimTimer + 1 == Obj_AnimDuration or Obj_AnimTimer <= 1
	{
		image_xscale = Facing;
	}	
	if image_xscale == FlipLeft
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