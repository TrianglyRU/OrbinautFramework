function ObjOrbstatueScript()
{
	if object_player_overlap(CollisionHitbox)
	{
		// Check if player can destroy Badnik
		if Player.InvincibilityBonus or Player.Jumping 
		or Player.Rolling or Player.SpindashRev >= 0 or Player.GlidingState
		{
			// Delete Badnik
			instance_destroy(self);
			
			// Spawn explosion, animal and play sound
			object_spawn(floor(x), floor(y), Animal);
			object_spawn(floor(x), floor(y), DustExplosion);
			audio_sfx_play(sfxDestroy, false, false);
			
			// Make player bounce if they are airborne
			if !Player.Grounded
			{
				if floor(Player.PosY) < floor(y)
				{
					Player.Ysp = -Player.Ysp;
				}
				else
				{
					Player.Ysp -= 1 * sign(Player.Ysp);
				}
			}
		}
	}
}