/// @self
/// @description Clears all active distortion effects from the foreground.
function dist_clear_fg()
{
	var _distortion = c_framework.distortion;
	var _layers = _distortion.fg_layers;
	
	for (var i = 0; i < array_length(_layers); i++)
	{
		var _layer = _layers[i];
		
		if layer_get_fx(_layers[i]) != -1
		{
			layer_clear_fx(_layer);
		}
	}
	
	_distortion.effect[0] = -1;
}
