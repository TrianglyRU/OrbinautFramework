/// @function get_tile(layer, x, y)
function get_tile(Layer, X, Y)
{
	return tilemap_get(Stage.TargetTileLayer[Layer], X div TileSize, Y div TileSize);
}