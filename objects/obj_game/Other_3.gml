/// @description Global Cleanup
ds_map_destroy(global.tile_widths);
ds_map_destroy(global.tile_heights);
ds_map_destroy(global.tile_angles);
ds_map_destroy(global.font_data);
ds_list_destroy(global.giant_rings);
ds_list_destroy(global.gamepads);
ds_list_destroy(global.looped_bgm);