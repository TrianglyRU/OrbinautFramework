function ObjLamppostActivation()
{
	if !Active 
	{
		if hitbox_collision(Player, self) 
		{
			// Set last used checkpoint ID to our ID
			Stage.LastCheckpoint = id;
			
			// Activate all inactive checkpoints with ID lower than ours
			var tempValue = LamppostID;
			with Lamppost if !Active and LamppostID <= tempValue 
			{
				Active = 1;
				animation_set(spr_obj_checkpoint_active, 1, true);
			}
			
			// Play sound
			sound_sfx_play(sfxLamppost, false);
		}
	}
}