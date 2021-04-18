/// @description Insert description here
// You can write your code in this editor
	
	// Move Motobug
	#region Movement
	{
		if StopTimer 
		{
			StopTimer--;
			if !StopTimer
			{
				Xsp  =  1;
				Dir *= -1;
			}
		}
		image_xscale = Dir;
		if Dir == -1
		{
			x -= Xsp;
		}
		else if Dir == 1
		{
			x += Xsp;
		}
		if Xsp != 0
		{
			if Dir == -1 and object_collide_tiles_h(SideLeft,  false, 0, LayerA)
			or Dir ==  1 and object_collide_tiles_h(SideRight, false, 0, LayerA)
			or !object_collide_tiles_v(false, SideBottom, 2, LayerA)
			{
				StopTimer = 60;
				Xsp       = 0;
			}
		}
	}
	#endregion
	
	// Check for hitbox overlap
	if object_check_overlap(CollisionHitbox)
	{
		if !Player.Rolling and !Player.Jumping and !Player.SpindashRev and !Player.GlidingState
		{
			object_do_damage(false);
		}
		else
		{
			instance_destroy(self);
			object_spawn(floor(x), floor(y), ExplosionFX);
			audio_sfx_play(sfxDestroy, false, false);
			
			if !Player.Grounded
			{
				if floor(Player.PosY) < y
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