/// @self
/// @description Removes the deformation effect from the specified layer, as well as from all other layers that share the same effect instance.
function deform_clear(_layer)
{
	var _effect = layer_get_fx(_layer);
	
	if _effect == -1
	{
		return;
	}
	
	var _ds_list = obj_game.deformations_data;
	
	for (var _i = ds_list_size(_ds_list) - 1; _i >= 0; _i--)
	{
		var _data = _ds_list[| _i];
		
		if _data != undefined && _data.effect == _effect
		{
			for (var _j = array_length(_data.layers) - 1; _j >= 0; _j--)
			{
				layer_clear_fx(_data.layers[_j]);
			}
			
			ds_list_delete(_ds_list, _i);
			
			break;
		}
	}
}