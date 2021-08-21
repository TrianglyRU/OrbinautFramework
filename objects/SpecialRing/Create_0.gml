/// @description Insert description here
// You can write your code in this editor
	
	// Create variables
	State = 0;
	Timer = 0;
	
	// Delete this ring if it was used before
	if !array_equals(Game.SpecialRingIDs, [])
	{
		for (var i = 0; i < array_length(Game.SpecialRingIDs); i++)
		{
			if id == Game.SpecialRingIDs[i]
			{
				instance_destroy();
			}
		}
	}	
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object size to 0
	image_xscale = 0;
	image_yscale = 0;