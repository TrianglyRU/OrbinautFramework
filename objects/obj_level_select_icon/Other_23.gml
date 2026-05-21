/// @description End Step (Post-Framework)
if obj_rm_level_select.level_entries[global.selected_level_entry] != "SOUND TEST"
{
	icon_to_draw = icon_map[? obj_rm_level_select.room_to_load];
}
else
{
	icon_to_draw = 1;
}