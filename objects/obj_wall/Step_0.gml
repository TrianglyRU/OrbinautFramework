if !iv_is_decorative
{
	FOR_EACH_PLAYER
	{
		solid_object(player_get(_p), SOLID_TYPE.SIDES);
	}
}