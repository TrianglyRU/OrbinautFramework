/// @function object_perform_damage(onOverlap, onTouching)
function object_perform_damage(onOverlap, onTouching)
{
	// Exit if player has been hurt already or invincible
	if Player.Hurt or Player.isInvincible exit;
	
	// Check if player is standing on us
	if onTouching
	{
		if Player.OnObject = id
		{
			// Hurt them using ours id
			Player.Hurt = id;
		}
	}
	
	// Check if player is overlapping us
	if onOverlap
	{
		if hitbox_collision(Player, id)
		{
			// Hurt them using ours id
			Player.Hurt = id;
		}
	}
}