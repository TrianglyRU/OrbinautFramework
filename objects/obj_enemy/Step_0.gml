/// @description Base Enemy Code
if instance_exists(obj_water_flash) && floor(y) >= obj_water.y
{
	replace_with_animal_by(player_get(0));
}
else
{
	var _player = react_to_players(REACT_TYPE.BADNIK);
	
	if _player != noone
	{
		replace_with_animal_by(_player);
	}
}