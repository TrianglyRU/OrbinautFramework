if !instance_is_drawn()
{
	instance_destroy();
}
else
{
	// Inherit the parent event
	event_inherited();
}