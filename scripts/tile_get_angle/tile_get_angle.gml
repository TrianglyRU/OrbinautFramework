/// @self
/// @description Retrieves the angle of a tile based on its index. Returns `ANGLE_EMPTY` if the tile of the given index is non-existent.
/// @param {Real} tiledata The tile data.
/// @returns {Real|Constant}
function tile_get_angle(_tiledata)
{
	var _index = tile_get_index(_tiledata) % ENGINE_TILE_COUNT;
	
	if _index <= 0
	{
		return ANGLE_EMPTY;
	}
	
	return c_framework.collision.tile_angle[_index];
}