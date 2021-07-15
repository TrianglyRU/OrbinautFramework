/// @function object_act_badnik(is_destroyable,instant_kill)
function object_act_badnik(is_destroyable, instant_kill)
{
	// Get position
	var XPos = variable_instance_exists(id, "PosX") ? floor(PosX) : floor(x);
	var YPos = variable_instance_exists(id, "PosY") ? floor(PosY) : floor(y);
	
	// Return badniks to their initial state if outside camera
	if !variable_instance_exists(id, "BadnikUnload")
	{
		UnloadOriginX = x;
		UnloadOriginY = y;
		BadnikUnload  = 1;
	}
	else
	{	
		// Check if object_set_activerange function was used
		if variable_instance_exists(id, "objActiveRange")
		{
			var UnloadBound = 32 * objActiveRange;
			
			// Check if Badnik left active range before the game unloads it
			if BadnikUnload == 1
			{
				if XPos < Screen.CameraX - UnloadBound or XPos > Screen.CameraX + Screen.Width + UnloadBound
				{	
					// Update flag
					BadnikUnload = 2;
				}
			}
			
			// Check if badnik should reset itself
			if BadnikUnload = 2
			{	
				// Return to its initial state if init coordinates are outside the range
				if UnloadOriginX < Screen.CameraX - UnloadBound or UnloadOriginX > Screen.CameraX + Screen.Width + UnloadBound
				{	
					BadnikUnload = 1
				
					x = UnloadOriginX;
					y = UnloadOriginY;
				
					event_perform(ev_create, 0);
				}
				
				// Else keep deactivated
				else
				{
					instance_deactivate_object(id);
				}
			}
		}	
	}
	
	// Exit if no collision happened
	if !object_player_overlap(CollisionHitbox)
	{
		exit;
	}
	
	// Check if player can destroy Badnik
	if is_destroyable
	{
		if Player.GlidingState == GlidingAir or Player.GlidingState == GlidingGround or Player.GlidingState == GlidingTurn
		or Player.InvincibilityBonus		 or Player.SpindashRev >= 0				 or Player.Rolling
		or Player.Jumping					 or Player.SuperState					 or Player.FlyingState == 1 and Player.Ysp < 0
		{		
			// Make player bounce if they are airborne
			if !Player.Grounded
			{
				if floor(Player.PosY) < YPos
				{
					Player.Ysp = -Player.Ysp;
				}
				else
				{
					Player.Ysp -= 1 * sign(Player.Ysp);
				}
			}
		
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
		
		// Damage player
		else
		{
			object_damage(false, false, instant_kill);
		}
	}
	
	// Damage player
	else
	{
		object_damage(false, false, instant_kill);
	}
}