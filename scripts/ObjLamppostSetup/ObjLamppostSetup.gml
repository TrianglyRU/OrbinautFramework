function ObjLamppostSetup()
{
	// Init lamppost
	animation_set(spr_obj_checkpoint, 0, false);
	Active = false;
	
	// Load as activated if its ID number is lower than activated one
	if Stage.LastCheckpoint != 0 and Stage.LastCheckpoint.LamppostID >= LamppostID
	{
		animation_set(spr_obj_checkpoint_active, 0, false);
		Active      = true;
	}
	
	// Render behind the player
	object_set_depth(false);
}