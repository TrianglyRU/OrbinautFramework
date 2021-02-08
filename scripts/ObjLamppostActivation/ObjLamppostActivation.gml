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
				image_index = 1;
			}
			
			// Play sound
			sound_sfx_play(sfxLamppost, false);
		}
	}
	else if Angle < 900 
	{
		Angle += 22.5;
		if (Angle == 900) image_index = 2;
	}
}