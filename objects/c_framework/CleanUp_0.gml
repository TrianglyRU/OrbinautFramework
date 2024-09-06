ds_list_destroy(ds_cull_list_pause);
ds_list_destroy(ds_cull_list_active);

ds_cull_list_pause = -1;
ds_cull_list_active = -1;

delete sprite_animator;

var _audio = audio;

audio_stop_all();

for (var i = 0; i < ENGINE_AUDIO_BGM_CHANNELS; i++)
{
	audio_emitter_free(_audio.emitter_bgm[i]);
}

audio_emitter_free(_audio.emitter_sfx);
delete _audio;

delete background;

for (var i = 0; i < CAMERA_COUNT; i++)
{
	camera_delete(i);
}

var _collision = collision;

ds_list_destroy(_collision.ds_sensors);
ds_list_destroy(_collision.ds_interact);
ds_list_destroy(_collision.ds_solid_size);
ds_list_destroy(_collision.ds_solid_side);
ds_list_destroy(_collision.ds_solid_push);

_collision.ds_sensors = -1;
_collision.ds_interact = -1;
_collision.ds_solid_size = -1;
_collision.ds_solid_side = -1;
_collision.ds_solid_push = -1;

delete _collision;

delete distortion;
delete fade;

var _input = input;

for (var i = 0; i < ENGINE_INPUT_MAX_DEVICE_COUNT; i++)
{
	delete _input.down[| i];
	delete _input.press[| i];
}

ds_list_destroy(_input.down);
ds_list_destroy(_input.press);

_input.down = -1;
_input.press = -1;

delete _input;

var _palette = palette;

ds_list_destroy(_palette.ds_colours);
_palette.ds_colours = -1;

delete _palette;