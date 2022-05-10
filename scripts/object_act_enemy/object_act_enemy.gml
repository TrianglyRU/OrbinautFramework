/// @function object_act_enemy(enemyType)
function object_act_enemy(enemyType)
{
	// Check for overlap with the player (ColHitbox2 -- we're taking Double Spin Attack into account)
	if !object_check_player(ColHitbox2)
	{
		return false;
	}
	
	// Check if player can damage our enemy
	var SpinCheck       = Player.Spinning    or Player.SpindashRev != -1;
	var InvincibleCheck = Player.SuperState  or Player.InvincibleBonus;
	var ActionCheck	    = Player.FlightState and floor(Player.PosY) > y or Player.GlideState > GlideFall;
	
	// Damage enemy
	if ActionCheck or SpinCheck or InvincibleCheck    
	{	
		switch enemyType
		{
			case EnemyBadnik:
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
			
				// Increase player score
				if Player.Spinning or Player.SpindashRev != -1
				{
					Player.ScoreCombo++;
				}
				var  Object = instance_create(x, y, ScoreObject);
				with Object
				{
					IsChain = true;
				}
			
				// Spawn animal and explosion
				instance_create(x, y, Animal);
				instance_create(x, y, DustExplosion);
			
				// Destroy badnik and play sound
				audio_sfx_play(sfxDestroy, false); 
				instance_destroy();
			}
			break;
			case EnemyBoss:
			{
				if !Player.Grounded
				{
					if Player.GlideState
					{
						Player.GlideState = GlideFall;
						Player.Animation  = AnimGlideFall;
						Player.RadiusX	  = Player.DefaultRadiusX;
						Player.RadiusY    = Player.DefaultRadiusY;
					
						// Reset gravity
						if !Player.IsUnderwater
						{
							Player.Grv = 0.21875;
						}
						else
						{
							// Reduce by 0x28 (0.15625) if underwater
							Player.Grv = 0.0625
						}
					}
					
					Player.Xsp *= -0.5;
					Player.Ysp *= -0.5;
				}
				
				audio_sfx_play(sfxBossHit, false);
			}
			break;
		}
		
		return true;
	}
	
	// Damage player
	player_damage(false, false, false); return false;
}