function GameRoomStartup()
{	
	// Setup room viewport 0
	view_enabled[0] = true;
	view_visible[0] = true;
	view_xport[0]   = 0;
	view_yport[0]   = 0;	
	view_wport[0]   = Game.Height;
	view_hport[0]   = Game.Width;
	
	// Adjust surfaces and camera view to game resolution
	application_set_size(Game.Width, Game.Height);
}