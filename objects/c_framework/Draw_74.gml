// RENDERER

// Set blend mode for drawing
gpu_set_blendmode_ext_sepalpha(bm_one, bm_inv_src_alpha, bm_one, bm_one);
gpu_set_blendenable(false);

for (var i = 0; i < CAMERA_COUNT; i++)
{
    var _camera = camera_get_data(i);
	
    if _camera == noone
    {
        continue;
    }
    
    var _surface = view_surface_id[i];
	
    if surface_exists(_surface)
    {
        draw_surface_part(_surface, ENGINE_RENDERER_HORIZONTAL_BUFFER, 0, _camera.surface_w - ENGINE_RENDERER_HORIZONTAL_BUFFER * 2, _camera.surface_h, _camera.surface_x, _camera.surface_y);
    }
}

// Restore default blend mode
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);