/// @description Cleanup
if room == rm_startup
{
	return;
}

// AUDIO

audio_stop_all();

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_free(audio_emitter_bgm[_i]);
}

audio_emitter_free(audio_emitter_sfx);

// COLLISION

ds_map_destroy(angle_map);
ds_map_destroy(markers);

// CULLING

ds_list_destroy(stopped_objects);

// DEFORMATION

ds_list_destroy(deformations_data);

// INPUT

ds_list_destroy(input_down);
ds_list_destroy(input_press);

// RENDERER

FOR_EACH_VIEW
{
	surface_free(view_surface_id[_v]);
	camera_destroy(view_camera[_v]);
}