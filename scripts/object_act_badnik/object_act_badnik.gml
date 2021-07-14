/// @function object_act_badnik(is_destroyable,instant_kill)
function object_act_badnik(is_destroyable, instant_kill)
{
	// Check if player can destroy Badnik
	if is_destroyable and (Player.Animation    == AnimRoll 
					   or  Player.GlidingState == GlidingAir 
				       or  Player.GlidingState == GlidingGround
					   or  Player.GlidingState == GlidingTurn
					   or  Player.SuperState   == SuperActive
					   or  Player.SpindashRev  >= 0
					   or  Player.InvincibilityBonus 
					   or (Player.FlyingState and Player.Ysp < 0))
	{
		// Delete Badnik
		instance_destroy();
		
		var PosX = floor(x);
		var PosY = floor(y);
		
		// Spawn explosion, animal and play sound
		instance_create(PosX, PosY, Animal);
		instance_create(PosX, PosY, DustExplosion);
		audio_sfx_play(sfxDestroy, false);
			
		// Make player bounce if they are airborne
		if !Player.Grounded
		{
			if floor(Player.PosY) < PosY
			{
				Player.Ysp = -Player.Ysp;
			}
			else
			{
				Player.Ysp -= 1 * sign(Player.Ysp);
			}
		}
		
		// Combo
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
		
		// Create score object
		instance_create(PosX, PosY, ComboScore);
	}
	else
	{
		object_damage(false, false, false);
	}
}