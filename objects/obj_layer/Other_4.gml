if scale_target_y != -1 && factor_y == 0
{
	show_debug_message($"[INFO] Recommened factor_y for {sprite_get_name(sprite_index)}: {string_format((y - camera_get_height(0) * 0.5) / (scale_target_y_init - camera_get_height(0) * 0.5), 10, 9)}");
}