function ObjTailsObjectDraw()
{
	// Update object
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);
	depth		 = Player.DrawOrder + 1;
	image_xscale = Player.Spinning and Player.Grounded ? sign(Player.Inertia) : sign(Player.Facing);
	image_angle  = VisualAngle;
	
	// Draw object
	draw_self();
}