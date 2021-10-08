function ObjTailsObjectStartup()
{
	// Create variables
	Angle		= 0;
	VisualAngle = 0;
	
	// Move tails to player
	x = floor(Player.PosX);
	y = floor(Player.PosY);
	
	// Set sprite
	sprite_index = spr_tails_tail_idle;
}