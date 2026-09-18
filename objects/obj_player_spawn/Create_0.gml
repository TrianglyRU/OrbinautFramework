instance_destroy();

if image_index == 0
{
	if array_contains(iv_sonic_spawn_excluded, global.player_main)
	{
		return;
	}
}
else if global.player_main != (image_index % image_number)
{
	return;
}

player_spawn(x, y, global.player_main);