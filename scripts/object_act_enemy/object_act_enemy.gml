/// @function object_act_enemy(enemyType)
function object_act_enemy(enemyType)
{
	// Exit if no collision is happening yet
	if !object_check_overlap(Hitbox)
	{
		exit;
	}
	
	// Check if player can damage enemy by gliding, spinning or spindashing
	var ActionCheck = Player.GlideState > GlideFall or Player.Spinning or Player.SpindashRev != -1;
	
	// Check if player can damage enemy because they are invincible
	var InvincibleCheck = Player.SuperState or Player.InvincibleBonus;
	
	// Check if Tails can damage enemy when flying
	var FlightCheck	= Player.FlightState and floor(Player.PosY) > y and Player.Ysp < 0;
	
	// Damage enemy
	if ActionCheck or FlightCheck or InvincibleCheck    
	{		
		// Make player bounce if they are airborne
		if !Player.Grounded
		{
			if floor(Player.PosY) > y or Player.Ysp < 0
			{
				Player.Ysp -= 1 * sign(Player.Ysp);	
			}
			else if Player.Ysp > 0
			{
				Player.Ysp = -Player.Ysp;
			}
		}
		
		// Check if enemy is a Badnik
		if enemyType == EnemyBadnik
		{
			// Count combo
			if Player.Spinning or Player.SpindashRev != -1
			{
				Player.ScoreCombo++;
			}
			
			// Spawn animal and explosion
			instance_create(x, y, Animal);
			instance_create(x, y, DustExplosion);
			
			// Increase player score
			var  Object = instance_create(x, y, ScoreObject);
			with Object
			{
				ComboTrigger = true;
			}
			
			// Play sound
			audio_sfx_play(sfxDestroy, false);
			
			// Destroy children
			if variable_instance_exists(id, "Obj_ChildrenIDs")
			{
				var Length = array_length(Obj_ChildrenIDs);
				for (var i = 0; i < Length; i++)
				{
					with Obj_ChildrenIDs[i]
					{
						instance_destroy();
					}
				}
			}
			
			// Destroy Badnik
			instance_destroy();
			
			return true;
		}
		
		// Check if enemy is a boss
		else if enemyType == EnemyBoss
		{
			if !Player.Grounded
			{
				// If gliding, stop
				if Player.GlideState
				{
					Player.GlideState = GlideFall;
					Player.Animation  = AnimGlideFall;
					
					// Reset collision radiuses
					Player.RadiusX = Player.DefaultRadiusX;
					Player.RadiusY = Player.DefaultRadiusY;
					
					// Reset gravity
					if !Player.IsUnderwater
					{
						Player.Grv	= 0.21875;
					}
					else
					{
						// Lower by 0x28 (0.15625) if underwater
						Player.Grv = 0.0625
					}
				}
				
				// Reverse speeds
				Player.Ysp = -Player.Ysp;
			}
			Player.Xsp = -Player.Xsp;
			
			// Play sound
			audio_sfx_play(sfxBossHit, false);
		}
		
		// Return success hit
		return true;
	}
	else
	{
		// Damage player
		player_damage(false, false, false);
	
		// Return failed hit
		return false;
	}
}