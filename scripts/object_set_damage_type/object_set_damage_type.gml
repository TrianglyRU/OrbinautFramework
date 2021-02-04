/// @function object_set_damage_type(whenStanding)
function object_set_damage_type(whenStanding)
{
	// If whenStanding flag is set, check if player is standing on us
	if whenStanding
	{
		if Player.OnObject = id
		{
			// Hurt them using ours id
			Player.Hurt = id;
		}
	}
	
	// If not, check for hitbox collision
	else
	{
		if hitbox_collision(Player, id)
		{
			// Hurt them using ours id
			Player.Hurt = id;
		}
	}				
}