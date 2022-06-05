/// @function tile_ignore_v(index,toPositive)
function tile_ignore_v(index,toPositive)
{
	/* Returns TRUE if the tile should be ignored, else returns FALSE */
	
	// Check for LBR Tiles
	if index > global.TileData[1] * 2
	{
		if object_index == Player
		{
			if !Player.Grounded or !Player.CollisionMode[0]
			{
				return toPositive;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return toPositive;
		}
	}
	
	// Check for Top Solid Tiles
	else if index > global.TileData[1]
	{
		if object_index == Player
		{
			if !Player.Grounded
			{
				return !toPositive;
			}
			else switch Player.CollisionMode[0]
			{
				case 0:
					return !toPositive;
				break;
				case 1:
					return true;
				break;
				case 2:
					return toPositive;
				break;
				case 3:
					return true;
				break;
			}
		}
		else
		{
			return !toPositive;
		}
	}
	
	// Do not ignore Full Solid Tiles
	else
	{
		return false;
	}
}