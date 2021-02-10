function ObjSignpostActivation()
{
	if !Active
	{
		// Activate on overlap and change stage state
		if Player.PosX > x
		{
			Active			  = true;
			Stage.TimeEnabled = false;
			Stage.State       = ActStateFinished;
			
			// Play sound
			audio_sfx_play(sfxSignpost, false);
		}
	}
	else
	{	
		// Start timer
		ActiveTimer++;
		
		// Spawn stars
		switch ActiveTimer 
		{
			case   2: instance_create_depth(x - 23, y - 14, depth - 1, RingSparkle); break;
			case  14: instance_create_depth(x + 7,  y + 7,  depth - 1, RingSparkle); break;
			case  26: instance_create_depth(x - 14, y,      depth - 1, RingSparkle); break;
			case  38: instance_create_depth(x + 23, y - 7,  depth - 1, RingSparkle); break;
			case  50: instance_create_depth(x,      y - 7,  depth - 1, RingSparkle); break;
			case  62: instance_create_depth(x + 14, y - 1,  depth - 1, RingSparkle); break;
			case  74: instance_create_depth(x - 23, y + 7,  depth - 1, RingSparkle); break;
			case  86: instance_create_depth(x + 23, y + 14, depth - 1, RingSparkle); break;
			case  98: instance_create_depth(x - 23, y - 14, depth - 1, RingSparkle); break;
			case 110: instance_create_depth(x + 7,  y + 7,  depth - 1, RingSparkle); break;
			case 122: instance_create_depth(x - 14, y,      depth - 1, RingSparkle); break;
			case 160: screen_fade_perform(to, black, 1);						 break;
			case 200: room_goto(MBZ);											 break;
		}	
	}
}