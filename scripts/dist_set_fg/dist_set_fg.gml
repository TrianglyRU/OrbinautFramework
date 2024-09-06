/// @self
/// @description Applies distortion to multiple foreground layers using two sets of distortion data. Distortion is not applied to object instance layers.
/// @param {Array<Real>} data1 The first set of distortion data.
/// @param {Array<Real>} data2 The second set of distortion data.
/// @param {Real} spd The speed of distortion.
/// @param {Real} range_start The upper boundary of the distortion area, in room space.
/// @param {Real} range_end The lower boundary of the distortion area, in room space.
/// @param {Array<String>} layers An array of layer names to which the distortion will be applied.
function dist_set_fg(_data1, _data2, _spd, _range_start, _range_end, _layers)
{
	// NOTE:
	// All filters & effects do not display correctly as of Runtime 2024.8.0.216. Please, follow our
	// Twitter, we'll let you know once the issue is fixed by YoYo!
	
	// Create the foreground distortion effect and check if it's valid
	var _effect = -1; // fx_create("_orbinaut_filter_distortion");
	
	if _effect == -1
	{
		exit;
	}
	
	var _distortion = c_framework.distortion;
	var _apply_flag = _distortion.apply_flag[0];
	var _effect_range = _distortion.effect_range[0];

	_distortion.fg_layers = _layers;
	_distortion.effect[0] = _effect;
	_distortion.offset_step[0] = _spd;
	_effect_range[0] = _range_start;
	_effect_range[1] = _range_end;

	// Apply wave data if provided
	if array_length(_data1) > 0
	{
		fx_set_parameter(_effect, "g_WaveHeight1", array_length(_data1));
		fx_set_parameter(_effect, "g_WaveData1", _data1);
		_apply_flag[0] = true;
	}

	if array_length(_data2) > 0
	{
		fx_set_parameter(_effect, "g_WaveHeight2", array_length(_data2));
		fx_set_parameter(_effect, "g_WaveData2", _data2);
		_apply_flag[1] = true;
	}

	// Set the effect to apply to single layers and assign it to each foreground layer
	fx_set_single_layer(_effect, true);

	for (var i = 0; i < array_length(_layers); i++)
	{
		layer_set_fx(_layers[i], _effect);
	}
}