function SplashScreenDraw()
{
	// Count timer
	RoomTimer++;
	
	// Draw splash
	if RoomTimer < 90 and SplashAlpha < 1
	{
		SplashAlpha += 0.05;
	}
	else if RoomTimer > 150
	{
		SplashAlpha -= 0.05;
	}
	draw_sprite_ext(gui_framework_splash, 1, Game.Width / 2, Game.Height / 2, 1, 1, 0, c_white, SplashAlpha);
	
	// Load into the next room after 3 seconds
	if RoomTimer == 180
	{
		room_goto(DevMenu);
	}
}