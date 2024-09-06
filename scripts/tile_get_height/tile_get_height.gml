/// @self
/// @description Retrieves the height of a specific tile in the room at a given x-coordinate within itself. Returns 0 if the tile index is invalid.
/// @param {Real} tiledata The tile data.
/// @param {Real} x The x-coordinate within the tile.
/// @returns {Real}
function tile_get_height(_tiledata, _x)
{
	var _index = tile_get_index(_tiledata) % ENGINE_TILE_COUNT;
	
	if _index <= 0
	{
		return 0;
	}
	
	// Calculate height index
	var _height_index;
	
	if tile_get_mirror(_tiledata)
	{
		_height_index = ENGINE_TILE_SIZE - 1 - _x % ENGINE_TILE_SIZE;
	}
	else
	{
		_height_index = _x % ENGINE_TILE_SIZE;
	}
	
	return c_framework.collision.tile_height[_index][_height_index];
}