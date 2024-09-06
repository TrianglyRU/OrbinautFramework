/// @self
/// @description Clears all active distortion effects from the background.
function dist_clear_bg()
{
	var _layer = c_framework.layer;
	
	if layer_get_fx(_layer) != -1
	{
		layer_clear_fx(_layer);
	}
	
	c_framework.distortion.effect[1] = -1;
}
