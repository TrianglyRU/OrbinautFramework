function ObjSpawnpointSetup()
{
	// Set object visibility
	visible = false;
	
	// Check if player has loaded straight from the previous act
	if Stage.ActID != 0 and Game.StageTransitionData[0] != 0
	{
		// Make spawnpoint visible
		visible = true;
		
		// Render behind the  player
		object_set_depth(Player, false);
		
		// Set signpost sprite
		animation_set_frame(spr_obj_spawnpoint_actend, 1);
		
		// Adjust position
		y -= 24;
	}
}