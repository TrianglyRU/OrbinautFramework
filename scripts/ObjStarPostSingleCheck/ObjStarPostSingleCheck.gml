function ObjStarPostStartup2()
{
	// Load as activated if ID is lower than the ID of activated one
	if Game.CheckpointID != 0 and Game.CheckpointID.ID >= ID
	{
		animation_set_frame(spr_obj_starpost_active, 1);
		Active = true;
		Angle  = 900;
	}
}