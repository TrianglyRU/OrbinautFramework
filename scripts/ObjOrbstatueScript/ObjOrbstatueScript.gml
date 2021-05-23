function ObjOrbstatueScript()
{
	if Player.InvincibilityBonus or Player.Jumping 
	or Player.Rolling or Player.SpindashRev >= 0 or Player.GlidingState
	{	
		// Check for hitbox overlap
		if object_player_overlap(CollisionHitbox)
		{
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
			
			// Spawn explosion and play its sound
			object_spawn(floor(x), floor(y), DustExplosion);
			audio_sfx_play(sfxDestroy, false, false);
			instance_destroy();
		}
	}
}