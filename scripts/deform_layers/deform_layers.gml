/// @self
/// @description							Applies a deformation effect to the specified layers.
/// @param {Array<String>} _layers			An array of layer names to which the deformation will be applied.
/// @param {Array<Real>|Undefined} _data1	The first set of deformation data values.
/// @param {Array<Real>|Undefined} _data2	The second set of deformation data values.
/// @param {Real} _factor					The vertical parallax factor of the deformation effect.
/// @param {Real} _speed					The speed at which the deformation moves or animates vertically, in pixels per step.
/// @param {Real} _range_start				The top boundary of the deformation area, in room-space.
/// @param {Real} _range_end				The bottom boundary of the deformation area, in room-space.
function deform_layers(_layers, _data1, _data2, _factor, _speed, _range_start, _range_end)
{
	var _effect = fx_create("_filter_layer_deformation");
	
	if _effect == -1
	{
		return;
	}
	
	var _data =
    {
		layers: _layers,
        effect: _effect,
		spd: _speed,
		factor: _factor,
		range_start: _range_start,
		range_end: _range_end,
		values_a: _data1,
		values_b: _data2,
		offset: 0
    };
	
	for (var _i = array_length(_layers) - 1; _i >= 0; _i--)
	{
		layer_set_fx(_layers[_i], _effect);
	}
	
	fx_set_single_layer(_effect, true);
	ds_list_add(obj_game.deformations_data, _data);
}