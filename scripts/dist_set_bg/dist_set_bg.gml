/// @self
/// @description Applies distortion to the background layer using two sets of distortion data.
/// @param {Array<Real>} data1 The first set of distortion data.
/// @param {Array<Real>} data2 The second set of distortion data.
/// @param {Real} spd The speed of distortion.
/// @param {Real} range_start The upper boundary of the distortion area, in background space.
/// @param {Real} range_end The lower boundary of the distortion area, in background space.
function dist_set_bg(_data1, _data2, _spd, _range_start, _range_end)
{
	// NOTE:
	// All filters & effects do not display correctly as of Runtime 2024.8.0.216. Please, follow our
	// Twitter, we'll let you know once the issue is fixed by YoYo!
	
	// Create the distortion effect and check if it's valid
	var _effect = -1; // fx_create("_orbinaut_filter_distortion");
	
	if _effect == -1
	{
		exit;
	}

	var _distortion = c_framework.distortion;
	var _apply_flag = _distortion.apply_flag[1];
	var _effect_range = _distortion.effect_range[1];

	// Set up the distortion effect with the specified parameters
	_distortion.effect[1] = _effect;
	_distortion.offset_step[1] = _spd;
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

	// Apply the effect to the specified layer
	layer_set_fx(c_framework.layer, _effect);
}