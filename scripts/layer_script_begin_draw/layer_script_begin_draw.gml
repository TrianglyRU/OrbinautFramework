/// @self
/// @description				A wrapper around layer_script_begin() that executes the callback only during the normal Draw event.
/// @param {String} _layer_id	The unique ID value of the layer to target (or the layer name as a string).
/// @param {Function} _script	The script function index to assign to the layer.
function layer_script_begin_draw(_layer_id, _script)
{
	var _data = { script: _script };
		
	layer_script_begin(_layer_id, method(_data, function()
	{
	    if event_type == ev_draw && event_number == ev_draw_normal
	    {
	        script();
	    }
	}));
}