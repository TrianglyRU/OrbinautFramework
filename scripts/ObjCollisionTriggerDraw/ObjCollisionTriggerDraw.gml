function ObjCollisionTriggerDraw()
{
	// Do not draw if not in devmode
	if !Game.DevMode
	{
		exit;
	}
	
	// Do not draw if ground only and player isn't grounded
	if GroundOnly and !Player.Grounded
	{
		exit;
	}
	
	// Draw
	draw_self();
}