/// @description Event
// You can call your scripts in this editor
	
	// Check for overlap and collide
	if !Player.Rolling or abs(Player.Inertia) < 4
	{
		object_collision_perform(false, true, false, false);
	}
