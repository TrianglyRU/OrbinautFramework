function object_do_damage(withHitbox, withSolidboxSide)
{
	if withHitbox       and object_check_overlap(CollisionHitbox)
	or withSolidboxSide and object_check_touch(withSolidboxSide)
	{
		// Hurt player
		Player.Hurt = id;
	}
}