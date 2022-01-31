/// @function LayerShaderEnd();
function LayerShaderEnd()
{
	if event_type == ev_draw and event_number == 0
    {
		shader_reset();
    }
}