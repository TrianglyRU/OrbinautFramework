function ObjSpawnpointSetup()
{
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Check if player should use spawnpoint to spawn
	if Game.PlayerPosition == 0
	{
		// Check which spawnpoint player should use
		if id.PlayerType == "Sonic & Tails" and Player.CharacterID == CharKnuckles
		or id.PlayerType == "Knuckles"		and Player.CharacterID != CharKnuckles
		{
			exit;
		}
		
		// Check if it is act transition
		if Game.StageTransitionData[4] == true
		{
			// Set player postion
			Player.PosX = x + Game.StageTransitionData[0];
			Player.PosY = y + Game.StageTransitionData[1] - Player.yRadius;
			
			// Set camera
			Screen.RawX    = floor(Player.PosX) - Game.StageTransitionData[0] - Screen.Width / 2;
			Screen.RawY    = floor(Player.PosY) - Game.StageTransitionData[2];
			Screen.CameraX = Screen.RawX;
			Screen.CameraY = Screen.RawY;
			
			// Set transition bottom boundary
			Stage.BottomBoundary = floor(Player.PosY + Player.yRadius) + Game.StageTransitionData[6];	
		}
		
		// Check if it is not act transition
		else
		{
			// Set player position on spawnpoint
			Player.PosX = x;
			Player.PosY = y - Player.yRadius;
			
			// Set camera
			Screen.RawX    = floor(Player.PosX) - Screen.Width  / 2;
			Screen.RawY    = floor(Player.PosY) - Screen.Height / 2 + 16;
			Screen.CameraX = Screen.RawX;
			Screen.CameraY = Screen.RawY;
		}
	}
	
	// Check if player has loaded straight from the previous act
	if Stage.ActID != 0 and Game.StageTransitions
	{
		// Make spawnpoint visible
		visible = true;
		
		// Disable animation
		image_speed = 0;
		
		// Render behind the player
		object_set_depth(Player, false);
		
		// Set signpost sprite
		animation_set_frame(spr_obj_spawnpoint_actend, Player.CharacterID + 1);
		
		// Adjust position
		y -= sprite_get_width(spr_obj_spawnpoint_actend) / 2 + 4;
	}
	
	// Set object visibility
	visible = false;
}