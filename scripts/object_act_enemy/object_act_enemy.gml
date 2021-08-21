/// @function object_act_enemy(badnik | boss)
function object_act_enemy(type)
{
	// Exit if no collision is happening yet
	if !object_player_overlap(Hitbox)
	{
		exit;
	}
	
	// Check if player can damage enemy
	var FlightCheck = Player.FlightState and floor(Player.PosY) > y and Player.Ysp < 0;
	
	if Player.GlideState == GlideActive or Player.Spinning		    or Player.SuperState
	or Player.InvincibleBonus			or Player.SpindashRev != -1 or FlightCheck
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
		if type == EnemyBadnik
		{
			// Get 50000 score target
			var LifeReward = max(ceil(Player.Score / 50000) * 50000, 50000);
			
			// Count combo
			if Player.Spinning or Player.SpindashRev != -1
			{
				Player.ScoreCombo++;
			}
		
			// Add score
			if Player.ScoreCombo < 2
			{
				Player.Score += 100;
			}
			else if Player.ScoreCombo < 3
			{
				Player.Score += 200;
			}
			else if Player.ScoreCombo < 4
			{
				Player.Score += 300;
			}
			else if Player.ScoreCombo < 16
			{
				Player.Score += 1000;
			}
			else
			{
				Player.Score += 10000;
			}
			
			// Grant extra life for exceeding 50000 points
			if Player.Score >= LifeReward
			{
				Game.Lives++;
				audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
			}
			
			// Spawn animal, score and explosion
			instance_create(x, y, Animal);
			instance_create(x, y, ComboScore);
			instance_create(x, y, DustExplosion);
			
			// Play sound
			audio_sfx_play(sfxDestroy, false);
			
			// Destroy Badnik
			instance_destroy();
			return true;
		}
		
		// Check if enemy is a boss
		else if type == EnemyBoss
		{
			if !Player.Grounded
			{
				// If gliding, stop
				if Player.GlideState == GlideActive
				{
					Player.GlideState = GlideDrop;
					Player.Animation  = AnimGlideDrop;
					
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