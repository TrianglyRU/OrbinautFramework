/// @self
/// @description Evaluates the validity of a tile along a horizontal axis based on the specified direction and tile behaviour.
/// @param {Real} tiledata The tile data.
/// @param {Enum.DIRECTION} dir The direction to check the tile's validity.
/// @param {Enum.TILEBEHAVIOUR} behaviour The behaviour of the tile to consider when evaluating validity.
/// @returns {Bool}
function tile_get_validity_h(_tiledata, _dir, _behaviour)
{
	switch floor(tile_get_index(_tiledata) / ENGINE_TILE_COUNT)
	{
		case 0:
			return true;
		
		// Handle behavior cases for the platform tiles
		case 1:
		
			switch _behaviour
			{
				case TILEBEHAVIOUR.DEFAULT:
				case TILEBEHAVIOUR.ROTATE_180:
					return false;

				case TILEBEHAVIOUR.ROTATE_90:
					return _dir == DIRECTION.POSITIVE;

				case TILEBEHAVIOUR.ROTATE_270:
					return _dir != DIRECTION.POSITIVE;
			}
		
		// Handle behavior cases for the LBR & invalid tiles
		default:
		
			switch _behaviour
			{		
				case TILEBEHAVIOUR.DEFAULT:
				case TILEBEHAVIOUR.ROTATE_180:
					return true;

				case TILEBEHAVIOUR.ROTATE_90:
					return _dir != DIRECTION.POSITIVE;

				case TILEBEHAVIOUR.ROTATE_270:
					return _dir == DIRECTION.POSITIVE;
			}
	}
}
