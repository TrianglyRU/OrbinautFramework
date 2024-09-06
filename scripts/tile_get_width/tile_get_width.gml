/// @self
/// @description Retrieves the width of a specific tile in the room at a given y-coordinate within itself. Returns 0 if the tile index is invalid.
/// @param {Real} tiledata The tile data.
/// @param {Real} y The y-coordinate within the tile.
/// @returns {Real}
function tile_get_width(_tiledata, _y)
{
	var _index = tile_get_index(_tiledata) % ENGINE_TILE_COUNT;
	
	if _index <= 0
	{
		return 0;
	}
	
	// Calculate width index
	var _width_index;
	
	if tile_get_flip(_tiledata)
	{
		_width_index = ENGINE_TILE_SIZE - 1 - _y % ENGINE_TILE_SIZE;
	}
	else
	{
		_width_index = _y % ENGINE_TILE_SIZE;
	}
	
	return c_framework.collision.tile_width[_index][_width_index];
}
