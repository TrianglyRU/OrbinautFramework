function ObjOrbstatueScript()
{
	if object_player_overlap(CollisionHitbox)
	{
		// Check if player can destroy Object
		if Player.Jumping or Player.Rolling or Player.SpindashRev >= 0
		or Player.InvincibilityBonus or Player.GlidingState
		{
			// Delete Object
			instance_destroy();
			
			// Spawn explosion, animal and play sound
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
			
			if (BossTrigger) object_spawn(x, y - 64, Orboss);
		}
	}
}