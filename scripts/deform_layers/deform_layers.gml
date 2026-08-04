/// @self
/// @description								Applies a deformation effect to the specified layers.
/// @param {Array<String>} _layers				An array of layer names to which the deformation will be applied.
/// @param {Real} _factor						The vertical parallax factor of the deformation effect.
/// @param {Real} _speed						The speed at which the deformation moves or animates vertically, in pixels per step.
/// @param {Real|Array<Real>|Undefined} _data_a	The primaty set of deformation data values.
/// @param {Real|Array<Real>|Undefined} _data_b	The secondary set of deformation data values.
function deform_layers(_layers, _factor, _speed, _data_a, _data_b)
{
	var _effect = fx_create("_filter_layer_deformation");
	
	if _effect == -1
	{
		return;
	}
	
	if _data_a != undefined && !is_array(_data_a)
	{
		_data_a = deform_get_data(_data_a);
	}
	
	if _data_b != undefined && !is_array(_data_b)
	{
		_data_b = deform_get_data(_data_b);
	}
	
	var _data =
	{
		layers: _layers,
        effect: _effect,
		spd: _speed,
		factor: _factor,
		values_a: _data_a,
		values_b: _data_b,
		offset: 0
	};
	
	fx_set_single_layer(_effect, true);
	
	for (var _i = array_length(_layers) - 1; _i >= 0; _i--)
	{
		layer_set_fx(_layers[_i], _effect);
	}
	
	ds_list_add(obj_game.deformations_data, _data);
}