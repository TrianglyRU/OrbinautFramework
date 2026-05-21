/// @description Room End Events
if room == rm_startup
{
	return;
}

// Clear VRAM
if clear_vram_on_room_end
{
	draw_texture_flush();
}

global.previous_room_id = room;