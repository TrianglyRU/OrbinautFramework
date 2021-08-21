function ObjStarPostStartup2()
{
	// Load as activated if ID is lower than the ID of activated one
	if Game.StarpostID != false and Game.StarpostID.ID >= ID
	{
		sprite_index = spr_obj_starpost_active;
		image_index  = 0;
		
		Active = true;
		Angle  = 900;
	}
}