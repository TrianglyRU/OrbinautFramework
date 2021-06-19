function ObjSpawnpointSetup()
{
	// Set object visibility
	visible = false;
	
	// Check if player has loaded straight from the previous act
	if Stage.ActID != 0 and Game.StageTransitions
	{
		// Make spawnpoint visible
		visible = true;
		
		// Disable animation
		image_speed = 0;
		
		// Render behind the  player
		object_set_depth(Player, false);
		
		// Set signpost sprite
		animation_set_frame(spr_obj_spawnpoint_actend, Player.CharacterID + 1);
		
		// Adjust position
		y -= sprite_get_width(spr_obj_spawnpoint_actend) / 2 + 4;
	}
}