// Inherit the parent event
event_inherited();

if variable_instance_exists(id, "ds_record_data")
{
	ds_list_destroy(ds_record_data);
	ds_record_data = -1;
}

with obj_player if player_index > other.player_index
{
	player_index--;
}