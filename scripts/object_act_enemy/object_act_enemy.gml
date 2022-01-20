/// @function object_act_enemy(enemyType)
function object_act_enemy(enemyType)
{
	// Wait until collision occurs
	if !object_check_overlap(TypeHitbox2)
	{
		return false;
	}
	
	// Check if player can damage enemy by gliding, spinning or spindashing
	var SpinCheck       = Player.Spinning    or Player.SpindashRev != -1;
	var InvincibleCheck = Player.SuperState  or Player.InvincibleBonus;
	var ActionCheck	    = Player.FlightState and floor(Player.PosY) > y and Player.Ysp < 0 or Player.GlideState > GlideFall;
	
	// Damage enemy
	if ActionCheck or SpinCheck or InvincibleCheck    
	{	
		switch enemyType
		{
			case TypeBadnik:
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
			
				// Destroy children
				var Length = array_length(Obj_ChildrenIDs);
				if  Length
				{
					for (var i = 0; i < Length; i++)
					{
						with Obj_ChildrenIDs[i] 
						{
							instance_destroy();
						}
					}
				}
			
				// Destroy badnik and play sound
				audio_sfx_play(sfxDestroy, false);
				instance_destroy();
			}
			break;
			case TypeBoss:
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
							Player.Grv = 0.21875;
						}
						else
						{
							// Lower by 0x28 (0.15625) if underwater
							Player.Grv = 0.0625
						}
					}
				
					// Reverse speeds
					Player.Xsp *= -0.5;
					Player.Ysp *= -0.5;
				}
				
				// Play sound
				audio_sfx_play(sfxBossHit, false);
			}
			break;
		}
		
		// Return successful hit
		return true;
	}
	
	// Damage player
	player_damage(false, false, false);
	
	// Return nothing
	return false;
}