/// @self
/// @description Destroys a background object located on the specified layer, and removes that temporary layer as well.
function bg_clear(_layer)
{
	with obj_parallax
	{
		if layer_get_name(layer) == _layer
		{
			instance_destroy();
			break;
		}
	}
}