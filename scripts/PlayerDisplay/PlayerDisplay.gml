function PlayerDisplay()
{	
	x			 = floor(PosX);
	y		     = floor(PosY);
	image_angle  = VisualAngle;
	
	// If spinning, update xscale once animation frame updates (in Sonic 1, it is always applied)
	if Animation != AnimSpin or Obj_AnimTimer == Obj_AnimDuration
	{
		image_xscale = Facing;
	}
	
	// Sprite is offset one pixel to the left when mirrored. Let's fix that
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