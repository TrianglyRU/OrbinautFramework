y = ystart;

FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	
	if _player != noone && _player.on_object == id
	{
		y = ystart + 8;
	}
	
	solid_object(_player, SOLID_TYPE.FULL);
}