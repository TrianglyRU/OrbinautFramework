/// @self
/// @description									Locates the collision tilemap at the given position by checking the secondary collision layer first and falling back to a main collision layer when needed.
/// @param {Real} _x                                The x-coordinate of the position.
/// @param {Real} _y                                The y-coordinate of the position.
/// @param {Enum.COLLISION_LAYER} _secondary_layer	The secondary collision layer to use when the main layer has no tile at the given position.
/// @returns {Id.TileMapElement}
function collision_tilemap_get(_x, _y, _secondary_layer)
{
	var _tilemap = obj_game.tilemaps[_secondary_layer];
	
	if _tilemap == -1 || tile_get_empty(tilemap_get_at_pixel(_tilemap, _x, _y))
	{
	    _tilemap = obj_game.tilemaps[COLLISION_LAYER.MAIN];
	}
	
	return _tilemap;
}