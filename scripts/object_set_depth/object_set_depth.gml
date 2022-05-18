/// @function object_set_depth(target,depthFlag)
function object_set_depth(target,depthFlag)
{
	// Apply depth relative to the player
	if target == Player
	{
		if instance_exists(Player)
		{
			switch object_index
			{
				/* You can add your objects for 
				more advanced depth manipulation here
			
				For objects rendered above the player, the higher 
				tolerance value means higher render priority
			
				For objects rendered below the player it means lower render priority */
			
				case Bridge:
					var Tolerance = 5;
				break;
				case BridgePost:
				case RingSparkle:
				case SpringYellowVertical:
				case SpringYellowHorizontal:
				case SpringYellowDiagonal:
				case SpringRedVertical:
				case SpringRedHorizontal:
				case SpringRedDiagonal:
					var Tolerance = 15;
				break;	
				default:     
					var Tolerance = 10; 
			}
			depth = Player.depth - (depthFlag ? Tolerance : -Tolerance);
		}
	}
	
	// Apply depth relative to another object
	else
	{
		depth = target.depth - (depthFlag ? 1 : -1);
	}
}