function ObjInvincibilityStarDraw()
{
	// Draw if not dead
	if !Player.Death and !Player.Drown
	{
		draw_self();
	}
}