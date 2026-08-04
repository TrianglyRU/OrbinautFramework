/// @self
/// @description								Applies a deformation effect to the specified layer and all layers behind it (by depth).
/// @param {String} _layer						The name of the layer at which depth the deformation will be applied.
/// @param {Real} _factor						The vertical parallax factor of the deformation effect.
/// @param {Real} _speed						The speed at which the deformation moves or animates vertically, in pixels per step.
/// @param {Real|Array<Real>|Undefined} _data_a	The primary set of deformation data values.
/// @param {Real|Array<Real>|Undefined} _data_b	The secondary set of deformation data values.
function deform_depth(_layer, _factor, _speed, _data_a, _data_b)
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
		layers: [_layer],
        effect: _effect,	
		spd: _speed,
		factor: _factor,
		values_a: _data_a,
		values_b: _data_b,
		offset: 0
	};
	
	layer_set_fx(_layer, _effect);
	ds_list_add(obj_game.deformations_data, _data);
}