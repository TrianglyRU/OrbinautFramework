/// @function object_perform_damage(whenStanding)
function object_perform_damage(whenStanding)
{
	// Report script error if instance is not set as an object
	if !variable_instance_exists(id, "IsStageObject")
	{
		show_message("Instance ID " + string(id) + " (" + string(object_get_name(self)) + ") is not initialized as object. Please, call function 'object_setup' in the Create or Room Start event");
		game_end();
	}
	
	// Exit if player has been hurt already or invincible
	if Player.Hurt or Player.isInvincible exit;
	
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
	if hitbox_collision(Player, id)
	{
		// Hurt them using ours id
		Player.Hurt = id;
	}		
}