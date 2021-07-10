/// @description Insert description here
// You can write your code in this editor

	// Check for hitbox overlap
	if object_player_overlap(CollisionHitbox)
	{
		// Damage player or be destroyed
		object_act_badnik(true, false);
	}