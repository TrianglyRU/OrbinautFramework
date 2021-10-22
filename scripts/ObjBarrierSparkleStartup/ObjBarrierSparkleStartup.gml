function ObjBarrierSparkleStartup()
{
	// Create variables
	Timer	  = 0;
	State     = 0;
	SparkleID = 0;
	
	// Set object depth
	object_set_depth(Barrier, true);
	
	// Set animation
	animation_play(sprite_index, 1, 0, 0);
}