function object_do_damage(withHitbox, withSolidboxTop, withSolidboxLeft, withSolidboxRight, withSolidboxBottom)
{
	if withHitbox == true
	{
		// Check if object's radiuses were initialized
		if !variable_instance_exists(id, "objXRadiusHit") or !variable_instance_exists(id, "objYRadiusHit")
		{
			show_message("Object ID " + string(id) + " does not have any hitbox radiuses to check for collision with player!");
			game_end();
			exit;
		}
		
		// Check for overlapping on X
		if floor(Player.PosX + 8) < x - objXRadiusHit 
		or floor(Player.PosX - 8) > x + objXRadiusHit
		{
			exit;
		}
		
		// Check for overlapping on Y
		if floor(Player.PosY - Player.yRadius + 3) > y + objYRadiusHit
		or floor(Player.PosY + Player.yRadius - 3) < y - objYRadiusHit
		{
			exit;
		}
		
		// Hurt player
		Player.Hurt = id;
	}
}