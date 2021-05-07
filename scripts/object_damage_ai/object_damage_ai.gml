/// @function object_damage_ai(isBadnik, isProjectile, instantKill)
function object_damage_ai(isBadnik, isProjectile, instantKill)
{
	// Exit if there is no AI in the stage
	if (!instance_exists(AI)) exit;
	
	// Check if this object is Badnik
	if isBadnik
	{
		// Check if player can destroy Badnik
		if AI.Jumping or AI.Rolling or AI.SpindashRev
		{
			// Delete Badnik
			instance_destroy(self);
			
			// Spawn explosion and play sound
			object_spawn(floor(x), floor(y), FireExplosion);
			audio_sfx_play(sfxDestroy, false, false);
			
			// Make player bounce if they are airborne
			if !AI.Grounded
			{
				if floor(AI.PosY) < floor(y)
				{
					AI.Ysp = -AI.Ysp;
				}
				else
				{
					AI.Ysp -= 1 * sign(AI.Ysp);
				}
			}
			
			// Exit the script
			exit;
		}
	}
	
	// Exit if player can't be damaged
	if (AI.isInvincible or AI.Hurt) exit;
	
	/* If we managed to get at this point, damage player */
	
	// Reset player flags
	AI.Grounded	   = false;
	AI.OnObject	   = false;
	AI.Rolling	   = false;
	AI.Jumping	   = false;
	AI.FlyingState = false;
	
	// Check if AI should die instantly
	if instantKill
	{
		// Set 'death' animation
		AI.Animation = AnimDeath;
			
		// Disable collisions and camera
		AI.AllowCollision = false;
		
		// Draw player above everything
		AI.DrawOrder = 0;
			
		// Perform movement
		AI.Inertia = 0;
		AI.Xsp	   = 0;
		AI.Ysp	   = -7;
		AI.Grv	   = 0.21875;
			
		// Enter death state
		AI.Death = true;
		
		// Play death sound (depending on what object is this)
		var deathSound = object_index == TripleSpikesV ? sfxDeathSpike : sfxDeath;
		audio_sfx_play(deathSound, false, true);
	}
		
	// Check if player has rings or barrier
	else
	{	
		// Set 'hurt' animation
		AI.Animation = AnimHurt;
			
		// Lose active barrier
		AI.ShieldType = false;

		// Perform movement
		AI.Ysp = -4;
		AI.Xsp =  2 * sign(AI.PosX - id.x);
		AI.Grv = 0.1875;
		
		// Enter hurt state
		AI.Hurt = true;
		
		// Play sound
		audio_sfx_play(sfxDeath, false, true);
	}
}