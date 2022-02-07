function ObjInvincibilityStarDraw()
{
	if Player.Death or Player.Drown
	{
		return;
	}
	draw_self();
}