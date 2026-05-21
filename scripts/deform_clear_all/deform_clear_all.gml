/// @self
/// @description Removes all deformation effects.
function deform_clear_all()
{
	var _ds_list = obj_game.deformations_data;
	
	for (var _i = ds_list_size(_ds_list) - 1; _i >= 0; _i--)
	{
		var _data = _ds_list[| _i];
		
		if _data != undefined
		{
			for (var _j = array_length(_data.layers) - 1; _j >= 0; _j--)
			{
				layer_clear_fx(_data.layers[_j]);
			}
			
			ds_list_delete(_ds_list, _i);
		}
	}
}