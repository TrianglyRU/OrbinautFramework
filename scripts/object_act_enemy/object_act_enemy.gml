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
	if Player.GlideState == GlideActive or Player.Rolling	   or Player.SuperState
	or Player.InvincibilityBonus		or Player.FlightState and Player.Ysp < 0
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
			// Start combo
			if !Player.Grounded or Player.SpindashRev >= 0
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
			// Knockback if grounded
			if Player.Grounded
			{
				Player.Xsp = -Player.Xsp;
				Player.Ysp = -Player.Ysp
			}
			
			// Play sound
			audio_sfx_play(sfxBossHit, false);
		}
		
		// Return succeed hit
		return true;
	}
		
	// Damage player
	object_damage(false, false, false);
	
	// Return failed hit
	return false;
}