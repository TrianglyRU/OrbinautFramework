/// @function object_act_enemy(enemy_type)
function object_act_enemy(enemy_type)
{
	// Get position
	var XPos = variable_instance_exists(id, "PosX") ? floor(PosX) : floor(x);
	var YPos = variable_instance_exists(id, "PosY") ? floor(PosY) : floor(y);
	
	// Exit if no collision happened
	if !object_player_overlap(CollisionHitbox)
	{
		exit;
	}
	
	// Check if player can damage enemy
	if Player.GlideState == GlideActive or Player.Spinning		   or Player.SuperState
	or Player.InvincibilityBonus		or Player.SpindashRev >= 0 or Player.FlightState and Player.Ysp < 0
	{		
		// Make player bounce if they are airborne
		if !Player.Grounded
		{
			if floor(Player.PosY) > YPos or Player.Ysp < 0
			{
				Player.Ysp -= 1 * sign(Player.Ysp);	
			}
			else if Player.Ysp > 0
			{
				Player.Ysp = -Player.Ysp;
			}
		}
		
		// Check if enemy is a Badnik
		if enemy_type == EnemyBadnik
		{
			// Get next extra life requirement
			var LifeReward = ceil(Player.Score / 50000) * 50000;
			
			// Count combo
			if Player.Spinning or Player.SpindashRev >= 0
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
			instance_create(XPos, YPos, Animal);
			instance_create(XPos, YPos, ComboScore);
			instance_create(XPos, YPos, DustExplosion);
			
			// Play sound
			audio_sfx_play(sfxDestroy, false);
			
			// Delete Badnik
			instance_destroy();
		}
		
		// Check if enemy is a boss
		else if enemy_type == EnemyBoss
		{
			if !Player.Grounded
			{
				if Player.GlideState == GlideActive
				{
					Player.GlideState = GlideDrop;
					Player.Animation  = AnimGlideDrop;
					
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
				Player.Ysp = -Player.Ysp;
			}
			Player.Xsp = -Player.Xsp;
			
			// Play sound
			audio_sfx_play(sfxBossHit, false);
		}
		
		// Return succeed hit
		return true;
	}
	else
	{
		// Damage player
		object_damage(false, false, false);
	
		// Return failed hit
		return false;
	}
}