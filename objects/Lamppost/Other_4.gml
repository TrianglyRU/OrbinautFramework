/// @description Initialization
// You can write your code in this editor
	
	// Init lamppost
	animation_set(spr_obj_checkpoint, 0);
	Active = false;
	
	// Load as activated if its ID number is lower than activated one
	if Stage.LastCheckpoint != 0 and Stage.LastCheckpoint.LamppostID >= LamppostID
	{
		animation_set(spr_obj_checkpoint_active, 0);
		Active      = true;
	}
	
	// Set draw order
	object_set_depth(false);
	
	