function StartupScreenDraw()
{
	static SplashAlpha = 0;
	
	if RoomTimer > 140 and SplashAlpha < 1
	{
		SplashAlpha += 0.05;
	}
	if RoomTimer < 20
	{
		SplashAlpha -= 0.05;
	}
	draw_sprite_ext(FrameworkSplash, 1, Game.Width / 2, Game.Height / 2, 1, 1, 0, c_white, SplashAlpha);
}